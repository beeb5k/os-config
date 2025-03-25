{unstable, ...}: {
  home.packages = with unstable; [
    vscode-fhs
    go
    zig
    rustup
    bun
    lua
  ];
}
