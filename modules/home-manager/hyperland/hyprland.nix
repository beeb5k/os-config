{
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      "$terminal" = "${pkgs.foot}/bin/foot";
      "$fileManager" = "${pkgs.nemo}/bin/nemo";
      "$menu" = "fuzzel";
      monitor = ",1920x1080@120,auto,1.0";
      general = {
        gaps_in = 6;
        gaps_out = 8;
        border_size = 2;
        resize_on_border = true;
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      decoration = {
        rounding = 10;
        blur = {
          enabled = false;
          size = 5;
          passes = 3;
          ignore_opacity = false;
          new_optimizations = true;
        };
        shadow = {
          enabled = false;
          range = 4;
          render_power = 3;
        };
      };

      exec-once = [
        "swaybg -i ${config.home.homeDirectory}/nixos-config/wallpapers/wallpaper.png -m fill"
      ];

      windowrulev2 = [
        # "float,class:^(foot)$,title:^(foot)$" # keeping this for reference
        "suppressevent maximize, class:.*" # Ignore maximize requests from apps
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0" # Fix some dragging issues with XWayland
      ];
    };
  };
}
