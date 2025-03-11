{pkgs, ...}: {
  # ---- Desktop Entries ----
  xdg.desktopEntries = {
    btop = {
      name = "btop";
      exec = "btop";
      noDisplay = true;
    };

    firefox = {
      name = "Firefox";
      exec = "firefox %u";
      icon = "/home/beeb5k/.mozilla/firefox/default/chrome/firefox-gnome-theme/icon.svg";
    };
  };

  # ---- Gnome Extensions List ----
  home.packages = with pkgs.gnomeExtensions; [
    blur-my-shell
    tiling-shell
    dash-to-dock
    rounded-window-corners-reborn
    just-perfection
    clipboard-indicator
    gsconnect
    alphabetical-app-grid
    emoji-copy
    appindicator
    caffeine
    privacy-settings-menu
  ];

  dconf = {
    enable = true;
    settings = {
      # ---- Gnome Settings ----
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

      "org/gnome/settings-daemon/plugins/media-keys".custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
      ];

      # ---- Gnome Extensions Settings ----
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = with pkgs.gnomeExtensions; [
          emoji-copy.extensionUuid
          tiling-shell.extensionUuid
          alphabetical-app-grid.extensionUuid
          dash-to-dock.extensionUuid
          rounded-window-corners-reborn.extensionUuid
          just-perfection.extensionUuid
          clipboard-indicator.extensionUuid
          appindicator.extensionUuid
          caffeine.extensionUuid
          privacy-settings-menu.extensionUuid
          system-monitor.extensionUuid
        ];

        disabled-extensions = [
          "window-list@gnome-shell-extensions.gcampax.github.com"
          "windowsNavigator@gnome-shell-extensions.gcampax.github.com"
          "light-style@gnome-shell-extensions.gcampax.github.com"
          "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
          "apps-menu@gnome-shell-extensions.gcampax.github.com"
          "native-window-placement@gnome-shell-extensions.gcampax.github.com"
          "stat"
          pkgs.gnomeExtensions.gsconnect.extensionUuid
        ];
      };

      "org/gnome/shell/extensions/just-perfection" = {
        theme = true; # Enable custom shell theme
        animation = 5; # lower the value, faster the animation. Default is 1
        invert-calendar-column-items = true;
        world-clock = false; # Disable World Clock in clock menu
        startup-status = 0; # Startup status: Desktop (0 = Desktop, 1 = Overview)
      };

      "org/gnome/shell/extensions/dash-to-dock" = {
        transparency-mode = "FIXED"; # Fixed transparency mode
        background-opacity = 0.8; # 80% opacity
        background-color = "rgb(0, 0, 0)"; # Black background

        apply-custom-theme = false; # Enable custom theme
        custom-background-color = true;
        running-indicator-style = "DASHES";
      };

      "org/gnome/shell/extensions/tilingshell" = {
        show-indicator = false; # Hide the indicator
      };

      "org/gnome/shell/extensions/system-monitor" = {
        show-cpu = true;
        show-memory = true;
        show-download = true;
        show-upload = false;
        show-swap = false;
      };
    };
  };
}
