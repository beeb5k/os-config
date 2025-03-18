{
  pkgs,
  unstable,
  ...
}: {
  home.packages =
    # Unstable packages
    (with unstable; [
      vscode
      go
      zig
      rustup
      bun
    ])
    ++
    # Stable packages
    (with pkgs; [
      (pkgs.discord.override {
        withVencord = true;
      })
      gnome-tweaks
      decibels
      dconf-editor
      bibata-cursors
      btop
      nitch
      blackbox-terminal
      swaylock
      swayidle
      swaybg
      base16-schemes
      ffmpeg-full
      mpv
      vlc
      imv # image viewer
      pkgs.autotiling-rs
      fastfetch
      libnotify
      satty
    ]);
}
