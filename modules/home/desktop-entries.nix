{pkgs, ...}: {
  xdg.dataFile."applications/foot-server.desktop".text = ''
    [Desktop Entry]
    Name=Foot Server
    Exec=${pkgs.foot}/bin/foot --server
    Type=Application
    NoDisplay=true
  '';

  xdg.dataFile."applications/footclient.desktop".text = ''
    [Desktop Entry]
    Name=Foot Client
    Exec=${pkgs.foot}/bin/footclient
    Type=Application
    NoDisplay=true
  '';
}
