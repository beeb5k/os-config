package main

import (
	"errors"
	"fmt"
	"os"
)

// colors defines ANSI color codes for terminal output styling
type colors struct {
	red    string // Red color code
	green  string // Green color code
	blue   string // Blue color code
	reset  string // Reset color code
	yellow string // Yellow color code
	normal string // Normal/default color code
}

// Status is a type alias for string representing different message types
type Status = string

// Constants defining different status types for message printing
const (
	Success Status = "success" // Indicates a successful operation
	Error   Status = "error"   // Indicates an error occurred
	Warning Status = "warning" // Indicates a warning message
	Info    Status = "info"    // Indicates an informational message
	Normal  Status = "normal"  // Indicates a normal message
)

// ScriptError provides more detailed error information
type ScriptError struct {
	Op  string
	Err error
}

// Error implements the error interface for ScriptError
func (e *ScriptError) Error() string {
	return fmt.Sprintf("%s failed: %v", e.Op, e.Err)
}

func main() {
	if err := runNixConfigScript(); err != nil {
		var scriptErr *ScriptError
		if errors.As(err, &scriptErr) {
			print_msg(Error, fmt.Sprintf("Operation %s failed: %v", scriptErr.Op, scriptErr.Err))
		} else {
			print_msg(Error, "Unexpected error:", err)
		}
		os.Exit(1)
	}
}

// runNixConfigScript orchestrates the entire configuration management process
func runNixConfigScript() error {
	// Validate root privileges
	if err := validateRootPrivileges(); err != nil {
		return &ScriptError{Op: "Root Privilege Check", Err: err}
	}

	// Get current working directory
	curr_dir, err := os.Getwd()
	if err != nil {
		return &ScriptError{Op: "Get Current Directory", Err: err}
	}

	// Files to process
	files := []string{"configuration.nix", "hardware-configuration.nix", "flake.nix", "flake.lock"}

	// Check file existence
	if err := check_file_exists(files, curr_dir); err != nil {
		return &ScriptError{Op: "File Existence Check", Err: err}
	}

	// Backup existing configuration files
	if err := backup_files(); err != nil {
		return &ScriptError{Op: "Backup Configuration Files", Err: err}
	}

	// Replace hardware configuration file
	if err := replace_hardware_file(curr_dir); err != nil {
		return &ScriptError{Op: "Replace Hardware Configuration", Err: err}
	}

	// Create symlinks
	if err := create_symlink(files, curr_dir); err != nil {
		return &ScriptError{Op: "Create Symlinks", Err: err}
	}

	// Print success message
	print_msg(Normal, "Completed successfully")
	return nil
}

// validateRootPrivileges checks if the script is run with root privileges
func validateRootPrivileges() error {
	uid := os.Getuid()
	if uid != 0 {
		return fmt.Errorf("you must run this script as root")
	}
	return nil
}

// create_symlink creates symbolic links for the specified files
// from the current directory to /etc/nixos/
// Returns an error if symlink creation fails
func create_symlink(files []string, curr_dir string) error {
	// check if the files exist
	err := check_file_exists(files, curr_dir)
	if err != nil {
		return err
	}

	for _, file := range files {
		target := "/etc/nixos/" + file
		source := curr_dir + "/" + file
		if _, err := os.Stat(target); err == nil {
			print_msg(Warning, "symlink already exists: ", target)
			continue
		}
		if err := os.Symlink(source, target); err != nil {
			return fmt.Errorf("error while creating symlink for file: %s", file)
		} else {
			print_msg(Info, "symlink created: ", target)
		}
	}

	return nil
}

// backup_files creates a backup of configuration files
// in a user-specific backup directory
// Returns an error if backup fails
func backup_files() error {
	path := "/etc/nixos"
	target := get_home_dir() + "/config-backup/"

	files := []string{"hardware-configuration.nix", "configuration.nix"}

	err := check_file_exists(files, path)
	if err != nil {
		return err
	}

	err = create_backup_directory()
	if err != nil {
		return fmt.Errorf("error while creating backup directory: %v", err)
	}

	for _, file := range files {
		err := os.Rename(path+"/"+file, target+file)
		if err != nil {
			return fmt.Errorf("error while moving file: %v", err)
		}
	}

	print_msg(Success, "files backed up successfully to: ", get_home_dir()+"/config-backup")
	return nil
}

func create_backup_directory() error {
	if _, err := os.Stat(get_home_dir() + "/config-backup"); err == nil {
		print_msg(Warning, "backup directory already exists")
		print_msg(Info, "removing existing backup directory")
		err := os.RemoveAll(get_home_dir() + "/config-backup")
		fmt.Println("removed")
		if err != nil {
			return fmt.Errorf("error while removing existing backup directory: %v", err)
		}
	}

	err := os.Mkdir(get_home_dir()+"/config-backup", 0755)
	if err != nil {
		return err
	}

	return nil
}

// check_file_exists verifies the existence of specified files
// in the given directory
// Returns an error with a list of missing files if any are not found
func check_file_exists(files []string, path string) error {
	list := []string{}
	for _, file := range files {
		if _, err := os.Stat(path + "/" + file); os.IsNotExist(err) {
			list = append(list, file)
		}
	}

	if len(list) > 0 {
		return fmt.Errorf("files not found: %v", list)
	}

	return nil
}

// replace_hardware_file replaces the hardware configuration file
// from a backup location to the current directory
// Returns an error if replacement fails
func replace_hardware_file(curr_dir string) error {
	// lets delete the hardware conf which was pulled from github.
	if _, err := os.Stat(curr_dir + "/hardware-configuration.nix"); os.IsExist(err) {
		err := os.Remove(curr_dir + "/hardware-configuration.nix")
		if err != nil {
			return fmt.Errorf("error while deleting hardware-configuration.nix")
		}
	}

	src_file := get_home_dir() + "/config-backup/hardware-configuration.nix"
	dst_file := curr_dir + "/hardware-configuration.nix"

	// lets copy the hardware conf from /etc/nixos to the current directory
	err := copy_file(src_file, dst_file)
	if err != nil {
		return fmt.Errorf("error while copying hardware-configuration.nix to :" + curr_dir)
	}

	return nil
}

// copy_file copies a file from source to destination
// Returns an error if copying fails at any stage
func copy_file(src, dst string) error {
	source, err := os.Open(src)
	if err != nil {
		return err
	}
	defer source.Close()

	destination, err := os.Create(dst)
	if err != nil {
		return fmt.Errorf("error while creating file: %v", err)
	}
	defer destination.Close()

	_, err = source.WriteTo(destination)
	if err != nil {
		return fmt.Errorf("error while copying file: %v", err)
	}

	return nil
}

// get_home_dir retrieves the home directory of the user
// who invoked the script with sudo
// Exits with an error if the sudo user is not detected
func get_home_dir() string {
	sudo_user := os.Getenv("SUDO_USER")
	// even tho we dont need this because we are already checking if the user is root in the main function
	// we will keep it here for now, because why not i like unnecessary code.
	if sudo_user == "" {
		print_msg(Error, "We never gonna see this error 🤪")
	}

	return "/home/" + sudo_user
}

// print_msg prints a message with color-coded formatting based on the message type
// Supports different status types: Success, Error, Warning, Info, and Normal
func print_msg(message_type Status, messages ...any) {
	color := colors{
		red:    "\033[31m",
		green:  "\033[32m",
		blue:   "\033[34m",
		reset:  "\033[0m",
		yellow: "\033[33m",
		normal: "\033[0m",
	}

	switch message_type {
	case Success:
		fmt.Printf(color.green + fmt.Sprint(messages...) + "\n" + color.reset)
	case Error:
		fmt.Printf(color.red + fmt.Sprint(messages...) + "\n" + color.reset)
	case Warning:
		fmt.Printf(color.yellow + fmt.Sprint(messages...) + "\n" + color.reset)
	case Info:
		fmt.Printf(color.blue + fmt.Sprint(messages...) + "\n" + color.reset)
	case Normal:
		fmt.Printf(color.normal + fmt.Sprint(messages...) + "\n" + color.reset)
	}
}
