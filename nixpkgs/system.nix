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
}
