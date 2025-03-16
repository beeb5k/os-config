{...}: {
  imports = [
    ./nixpkgs/user.nix
    ./modules/home/firefox.nix
    ./modules/home/fonts.nix
    ./modules/home/git.nix
    ./modules/home/gnome.nix
    ./modules/home/nvim.nix
    ./modules/home/obs.nix
    ./modules/home/zsh.nix
  ];

  home.username = "beeb5k";
  home.homeDirectory = "/home/beeb5k";

  home.stateVersion = "24.11";

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "code";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
