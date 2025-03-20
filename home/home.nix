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
    TERMINAL = "foot";
    TERMINAL_EMULATOR = "foot";
    TERM = "foot";
    BROWSER = "firefox";
  };

  programs.home-manager.enable = true;
}
