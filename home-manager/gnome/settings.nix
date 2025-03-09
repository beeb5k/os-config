{...}: {
  dconf = {
    enable = true;
    settings = {
      # Enable minimize,maximize,close buttons for windows
      "org/gnome/desktop/wm/preferences" = {
        "button-layout" = ":minimize,maximize,close";
      };

      # set default accent color
      "org/gnome/desktop/interface" = {
        accent-color = "slate"; # Options : blue, teal, green, yellow, orange, red, purple, pink and slate
      };

      # Dark theme by default.
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        cursor-theme = "Bibata-Original-Ice";
        clock-format = "12h";
        font-hinting = "medium"; # Options: none, slight, medium, full
      };

      # Center new windows
      "org/gnome/mutter" = {
        "center-new-windows" = true;
      };

      "org/gnome/desktop/calendar" = {show-weekdate = true;};
      "org/gtk/settings/file-chooser" = {clock-format = "12h";};

      # ---- Custom keybindings ----
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Super>b";
        command = "firefox";
        name = "browser";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
        binding = "<Super>e";
        command = "/usr/bin/env nautilus";
        name = "File Manager";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
        binding = "<Super>Return";
        command = "blackbox";
        name = "Terminal";
      };

      # "org/gnome/shell/keybindings/toggle-overview" = "<Super>.";

      "org/gnome/settings-daemon/plugins/media-keys".custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
      ];
    };
  };
}
