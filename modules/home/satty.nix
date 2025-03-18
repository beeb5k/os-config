{
  home.file.".config/satty/config.toml".text = ''
    [general]
    # Start Satty in fullscreen mode
    fullscreen = true
    # Exit directly after copy/save action
    early-exit = true
    # Select the tool on startup [possible values: pointer, crop, line, arrow, rectangle, text, marker, blur, brush]
    initial-tool = "brush"
    # Configure the command to be called on copy, for example `wl-copy`
    copy-command = "wl-copy"
    # Increase or decrease the size of the annotations
    annotation-size-factor = 2
    # Filename to use for saving action. Omit to disable saving to file. Might contain format specifiers: https://docs.rs/chrono/latest/chrono/format/strftime/index.html
    output-filename = "/tmp/test-%Y-%m-%d_%H:%M:%S.png"
    # Action to perform when the Enter key is pressed [possible values: save-to-clipboard, save-to-file]
    # action-on-enter = "save-to-clipboard"
    # After copying the screenshot, save it to a file as well
    save-after-copy = false
    # Hide toolbars by default
    default-hide-toolbars = false
    # The primary highlighter to use, the other is accessible by holding CTRL at the start of a highlight [possible values: block, freehand]
    primary-highlighter = "block"
    disable-notifications = true

    # Font to use for text annotations
    [font]
    family = "Roboto"
    style = "Bold"
  '';

  home.file."bin/screenshot.sh" = {
    text = ''
      #!/bin/sh
      # create screenshot dir if it doesn't exist
      if [ ! -d ~/Pictures/Screenshots ]; then
        mkdir -p ~/Pictures/Screenshots
      fi
      grim -t ppm - | satty --filename - --fullscreen --output-filename ~/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png
    '';
    executable = true;
  };
}
