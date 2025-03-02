{pkgs, ...}: {
  home.packages = with pkgs; [
    gnome-tweaks
    decibels
    errands
  ];
}
