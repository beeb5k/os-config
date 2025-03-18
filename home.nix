{pkgs, ...}: {
  imports = [
    # ./modules/home/gnome.nix
    ./nixpkgs/user.nix
    ./modules/home/firefox.nix
    ./modules/home/fonts.nix
    ./modules/home/git.nix
    ./modules/home/nvim.nix
    ./modules/home/obs.nix
    ./modules/home/zsh.nix
    ./modules/home/terminal.nix
    ./modules/home/fuzzel.nix
    ./modules/home/file-manager.nix
    ./modules/home/stylix.nix
    ./modules/home/desktop-entries.nix
    ./modules/home/satty.nix
    ./modules/home/waybar.nix
    ./modules/home/mako.nix
    ./modules/home/hyprland.nix
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

  # Let Home Manager install a nd manage itself.
  programs.home-manager.enable = true;
}
