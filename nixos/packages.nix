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
    libnotify
    satty
    wl-clipboard
    pavucontrol
    pamixer
    greetd.tuigreet
    brightnessctl
    mtpfs
    libmtp
  ];
}
