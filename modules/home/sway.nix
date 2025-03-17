{pkgs, ...}: {
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = rec {
      window = {
        border = 1;
        titlebar = false;
      };
      gaps = {
        inner = 5;
        outer = 5;
      };
      modifier = "Mod4";
      terminal = "${pkgs.foot}/bin/foot";
      menu = "fuzzel";
      startup = [
        {command = "waybar";}
        {command = "mako";}
        {
          command = "swaymsg workspace 1";
          always = true;
        }
      ];
      bars = [];
    };
  };
}
