{pkgs, ...}: {
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-vaapi
      obs-vkcapture
      obs-nvfbc
      obs-move-transition
      obs-pipewire-audio-capture
    ];
  };
}
