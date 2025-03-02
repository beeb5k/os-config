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
    };
  };
}
