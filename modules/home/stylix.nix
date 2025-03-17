{pkgs, ...}: {
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    polarity = "dark";
    image = ../../wallpapers/wallpaper.jpg;

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
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
