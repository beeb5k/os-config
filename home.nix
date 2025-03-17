{pkgs, ...}: {
  imports = [
    ./nixpkgs/user.nix
    ./modules/home/firefox.nix
    ./modules/home/fonts.nix
    ./modules/home/git.nix
    # ./modules/home/gnome.nix
    ./modules/home/nvim.nix
    ./modules/home/obs.nix
    ./modules/home/zsh.nix
    ./modules/home/foot.nix
    ./modules/home/fuzzel.nix
    ./modules/home/file-manager.nix
    ./modules/home/stylix.nix
    ./modules/home/sway.nix
  ];

  home.username = "beeb5k";
  home.homeDirectory = "/home/beeb5k";

  home.stateVersion = "24.11";

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    TERMINAL = "${pkgs.foot}/bin/foot";
    TERMINAL_EMULATOR = "${pkgs.foot}/bin/foot";
    TERM = "${pkgs.foot}/bin/foot";
    BROWSER = "firefox";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
