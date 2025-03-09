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
    go
    nim
  ];

  # delete preinstalled apps
  environment.gnome.excludePackages = with pkgs; [gnome-tour gnome-weather gnome-music pantheon.epiphany geary gnome-maps kgx];
  services.xserver.excludePackages = with pkgs; [xterm];
}
