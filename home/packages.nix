{pkgs, ...}: {
  home.packages = with pkgs; [
    (pkgs.discord.override {
      withVencord = true;
    })
    bibata-cursors
    nitch
    swaybg
    base16-schemes
    ffmpeg-full
    mpv
    imv
    fastfetch
    libnotify
    satty
    wl-clipboard
  ];
}
