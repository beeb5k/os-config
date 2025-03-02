{pkgs, ...}: {
  home.packages = with pkgs; [
    cascadia-code
    fira-code
  ];
}
