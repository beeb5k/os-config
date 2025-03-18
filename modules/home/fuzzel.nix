{pkgs, ...}: {
  programs.fuzzel = {
    enable = true;
    settings.main = {
      terminal = "${pkgs.foot}/bin/foot -e";
      exit-immediately-if-empty = "yes"; # idk what it does found this in someones config.
    };
  };
}
