{pkgs, ...}: {
  stylix = {
    enable = true;
    autoEnable = true;
    targets.firefox.enable = false;
    targets.waybar.enable = false;
    targets.kde.enable = false;
    targets.gnome.enable = false;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    polarity = "dark";
    image = ../../wallpapers/wallpaper.jpg;

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 16;
    };

    fonts = {
      sizes = {
        applications = 12;
        terminal = 12;
        desktop = 12;
      };
    };

    opacity = {
      terminal = 1.0;
    };
  };
}
