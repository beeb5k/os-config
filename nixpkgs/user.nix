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
      bun
      rustup
      zig

    ]);
}
