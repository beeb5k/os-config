import std/posix, os, strformat;

proc validateRootPrivileges() =
  ##[ checks if the user is root ]##
  if getuid() != 0:
    echo "You must be root to run this program.";
    quit(1);

proc check_file_exists(files: seq[string], path: string) =
  ##[ checks if the files exist in the given path ]##
  var notFoundFiles: seq[string];
  for file in files:
    if not fileExists(path & $file):
      notFoundFiles.add(file);

  if not notFoundFiles.len == 0:
    echo "Error: The following files are missing in the path: ";
    for file in notFoundFiles:
      echo file;
    quit(1);

proc create_bak_dir(path: string): string =
  ##[ creates backup directory ]##
  try:
    createDir(path & "backup");
    return path & "backup/";
  except OSError:
    echo "Error: " & getCurrentExceptionMsg();
    quit(1);

proc isSymlink(file: string): bool =
  ##[ checks if the file is a symlink ]##
  if symlinkExists(file):
    echo "Symlink found: " & extractFilename(file);
    return true;
  return false;

proc create_backup(source_path: string, dist_path: string) =
  ##[ creates backup of default nixos config in curr dir ]##
  let backup_dir_path = create_bak_dir(dist_path); # create backup dir
  for file in walkDir(source_path):
    if not isSymlink(file.path):
      try:
        moveFile(file.path, backup_dir_path & extractFilename(file.path) &
            ".bak");
      except OSError:
        echo "Error: " & getCurrentExceptionMsg();
    else:
      echo fmt"Cannot backup {file.path} as it's a symlink.";
      quit(1);

proc replace_hardware_conf(source_path: string, dist_path: string) =
  ##[ replaces hardware-configuration.nix file with default hardware-configuration.nix
    which is automatically generated by nixos during installation ]##
  for file in walkDir(source_path):
    if extractFilename(file.path) == "hardware-configuration.nix":
      if isSymlink(file.path):
        echo fmt"Cannot replace {file.path} with default hardware-configuration.nix as it's a symlink.";
      else:
        try:
        # lets copy the hardware-configuration.nix file to the current directory
          copyFile(file.path, dist_path & "hardware-configuration.nix");
        except CatchableError:
          echo "Error: " & getCurrentExceptionMsg();
          quit(1);

proc create_symlink(source_path: string, dist_path: string) =
  ##[ creates symlink of the default nixos configuration files in the current directory ]##
  const files = ["configuration.nix", "hardware-configuration.nix", "flake.nix",
      "flake.lock"];
  for file in files:
    try:
      os.createSymlink(dist_path & file, source_path & file);
    except CatchableError:
      echo "Error: " & getCurrentExceptionMsg();
      quit(1);


proc main() =
  let TARGET_PATH = "/etc/nixos/"; # path to the default nixos configuration files
  let DEST_PATH = getCurrentDir() & "/"; # path to the current directory where the script is running
  let default_files = ["configuration.nix", "hardware-configuration.nix"]; # list of default nixos configuration files

  validateRootPrivileges()
  check_file_exists(@default_files,
    TARGET_PATH);
  replace_hardware_conf(TARGET_PATH, DEST_PATH);
  create_backup(TARGET_PATH, DEST_PATH);
  create_symlink(TARGET_PATH, DEST_PATH);



main();
