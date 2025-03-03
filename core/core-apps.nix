{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    wget
    git
    file
    binutils
    eza
    xclip
    bat
    ripgrep
    fzf
    dconf
  ];

  # delete preinstalled apps
  environment.gnome.excludePackages = with pkgs; [gnome-tour gnome-weather gnome-music nixos-render-docs pantheon.epiphany geary gnome-maps];
  services.xserver.excludePackages = with pkgs; [xterm];
}
