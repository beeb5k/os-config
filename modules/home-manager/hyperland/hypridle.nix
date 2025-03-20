{pkgs, ...}: {
  home.packages = with pkgs; [
    sway-audio-idle-inhibit # Prevents the screen from turning off when audio is playing
  ];
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pgrep hyprlock || hyprlock"; # Only start hyprlock if not already running
        before_sleep_cmd = "loginctl lock-session"; # Lock before suspend (lid close)
        after_sleep_cmd = "hyprctl dispatch dpms on"; # Turn display back on after wake
      };
      listener = [
        # Lock screen after 5 minutes (300 seconds) of inactivity
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        # Turn off screen after 6 minutes (360 seconds)
        {
          timeout = 360;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        # Suspend after 30 minutes (1800 seconds)
        {
          timeout = 1800;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
