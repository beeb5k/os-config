{pkgs, ...}: {
  home.packages = with pkgs; [
    (pkgs.discord.override {
      withVencord = true;
    })
    gnome-tweaks
    decibels
    errands
    dconf-editor
    bibata-cursors
    vscode
    btop
    nitch
  ];
}
