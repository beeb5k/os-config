{pkgs, ...}: {
  imports = [
    ./programs/zsh.nix
    ./programs/git.nix
    ./programs/obs.nix
    ./programs/fonts.nix
    ./gnome/settings.nix
    ./gnome/extensions.nix
    ./gnome/core-apps.nix
    ./gnome/desktopEntries.nix
  ];

  home.username = "beeb5k";
  home.homeDirectory = "/home/beeb5k";

  home.stateVersion = "24.11";

  nixpkgs.config.allowUnfree = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    (pkgs.discord.override {
      withVencord = true;
    })
    vscode
    btop
    ghostty

    nixd
    alejandra
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nano";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
