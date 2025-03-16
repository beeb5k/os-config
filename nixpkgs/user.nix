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
    ]);
}
