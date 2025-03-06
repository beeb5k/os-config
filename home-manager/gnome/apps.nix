{pkgs, ...}: {
  home.packages = with pkgs; [
    gnome-tweaks
    decibels
    errands
    dconf-editor
    bibata-cursors
  ];
}
