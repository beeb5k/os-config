{pkgs, ...}: {
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
        ];
        disabled-extensions = [
          "window-list@gnome-shell-extensions.gcampax.github.com"
          "windowsNavigator@gnome-shell-extensions.gcampax.github.com"
          "light-style@gnome-shell-extensions.gcampax.github.com"
          "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
          "apps-menu@gnome-shell-extensions.gcampax.github.com"
          "native-window-placement@gnome-shell-extensions.gcampax.github.com"
          "status-icons@gnome-shell-extensions.gcampax.github.com"
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
    };
  };
}
