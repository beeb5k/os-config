{unstable, ...}: {
  home.packages = with unstable; [
    vscode
    go
    zig
    rustup
    bun
  ];
}
