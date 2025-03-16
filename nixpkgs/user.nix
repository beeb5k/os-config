{
  pkgs,
  unstable,
  ...
}: {
  home.packages =
    # Unstable packages
    (with unstable; [
      vscode
      zed-editor
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
      errands
      dconf-editor
      bibata-cursors
      btop
      nitch
      bun
      rustup
      zig

    ]);
}
