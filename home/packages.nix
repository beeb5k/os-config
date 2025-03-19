{pkgs, ...}: {
  home.packages = with pkgs; [
    (pkgs.discord.override {
      withVencord = true;
    })
    (nerdfonts.override {
      fonts = ["JetBrainsMono"];
    })
    grim
    bibata-cursors
    nitch
    swaybg
    base16-schemes
    ffmpeg-full
    mpv
    imv
    fastfetch
  ];
}
