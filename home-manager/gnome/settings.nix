{...}: {
  dconf = {
    enable = true;
    settings = {
      # Enable minimize,maximize,close buttons for windows
      "org/gnome/desktop/wm/preferences" = {
        "button-layout" = ":minimize,maximize,close";
      };
      # Dark theme by default.
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };
}
