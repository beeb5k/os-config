{pkgs, ...}: {
  home.packages = with pkgs; [
    (pkgs.discord.override {
      withVencord = true;
    })
    grim
    nitch
    swaybg
    base16-schemes
    ffmpeg-full
    mpv
    imv
    fastfetch
  ];
}
