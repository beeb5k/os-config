{pkgs, ...}: {
  programs.fuzzel = {
    enable = true;
    settings.main = {
      # Nested under 'main' section
      terminal = "${pkgs.foot}/bin/foot -e";
    };
  };
}
