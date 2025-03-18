{pkgs, ...}: {
  home.packages = with pkgs; [
    trash-cli
    xfce.thunar
  ];

  programs.lf.enable = true;
}
