{pkgs, ...}: {
  imports = [
    ../modules/home-manager/default.nix
    ./packages-unstable.nix
    ./packages.nix
  ];

  home.username = "beeb5k";
  home.homeDirectory = "/home/beeb5k";

  home.stateVersion = "24.11";

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    TERMINAL = "${pkgs.foot}/bin/foot";
    TERMINAL_EMULATOR = "${pkgs.foot}/bin/foot";
    TERM = "${pkgs.foot}/bin/foot";
    BROWSER = "firefox";
  };

  programs.home-manager.enable = true;
}
