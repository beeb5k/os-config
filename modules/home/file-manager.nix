{pkgs, ...}: {
  home.packages = with pkgs; [
    trash-cli
  ];

  programs.lf.enable = true;
}
