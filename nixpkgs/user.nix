{
  pkgs,
  unstable,
  ...
}: {
  home.packages =
    # Unstable packages
    (with unstable; [
      vscode-fhs
      zed-editor-fhs
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
