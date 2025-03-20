{
  pkgs,
  config,
  ...
}: let
  myCss = builtins.readFile ./style.css;

  workspaces = {
    format = "{icon}";
    format-icons = {
      "1" = "";
      "2" = "";
      "3" = "";
      active = "";
      default = "";
      urgent = "";
    };
    on-click = "activate";

    # persistent_workspaces = {"*" = 10;};
  };

  mainWaybarConfig = {
    mod = "dock";
    layer = "top";
    gtk-layer-shell = true;
    height = 14;
    position = "top";
    spacing = 4;
    # fixed-center = true; # idk what this does

    modules-left = ["custom/logo" "hyprland/workspaces" "mpris"];
    modules-right = [
      # "custom/gpu-usage"
      "cpu"
      "memory"
      "power-profiles-daemon"
      "network"
      "bluetooth"
      "pulseaudio"
      "pulseaudio#microphone"
      "battery"
      "tray"
    ];
    modules-center = [
      "clock"
      # "hyprland/window"
    ];

    "wlr/workspaces" = workspaces;
    "hyprland/workspaces" = workspaces;

    bluetooth = {
      format = "";
      format-connected = " {num_connections}";
      format-disabled = "";
      tooltip-format = " {device_alias}";
      tooltip-format-connected = "{device_enumerate}";
      tooltip-format-enumerate-connected = " {device_alias}";
    };

    power-profiles-daemon = {
      format = "{icon}";
      tooltip-format = "Power profile: {profile}\nDriver: {driver}";
      tooltip = true;
      format-icons = {
        default = "";
        performance = "";
        balanced = "";
        power-saver = "";
      };
    };

    mpris = {
      format = "DEFAULT: {player_icon} {dynamic}";
      format-paused = "DEFAULT: {status_icon} <i>{dynamic}</i>";
      player-icons = {
        "default" = "▶";
        "mpv" = "🎵";
      };
      status-icons = {
        "paused" = "⏸";
      };
      # "ignored-players": ["firefox"]
    };

    clock = {
      actions = {
        on-click-backward = "tz_down";
        on-click-forward = "tz_up";
        on-click-right = "mode";
        on-scroll-down = "shift_down";
        on-scroll-up = "shift_up";
      };
      calendar = {
        format = {
          days = "<span color='#ecc6d9'><b>{}</b></span>";
          months = "<span color='#ffead3'><b>{}</b></span>";
          today = "<span color='#ff6699'><b><u>{}</u></b></span>";
          weekdays = "<span color='#ffcc66'><b>{}</b></span>";
          weeks = "<span color='#99ffdd'><b>W{}</b></span>";
        };
        mode = "year";
        mode-mon-col = 3;
        on-click-right = "mode";
        on-scroll = 1;
        weeks-pos = "right";
      };
      format = "󰥔 {:%I:%M %p}";
      format-alt = "󰥔 {:%A, %B %d, %Y (%R)} ";
      tooltip-format = ''
        <span size='9pt' font='WenQuanYi Zen Hei Mono'>{calendar}</span>'';
    };

    cpu = {
      format = "󰍛 {usage}%";
      format-alt = "{icon0}{icon1}{icon2}{icon3}";
      format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
      interval = 10;
    };

    battery = {
      bat = "BAT1";
      interval = 10;
      states = {
        warning = 30;
        critical = 15;
      };
      format = "{icon} {capacity}%";
      format-icons = ["" "" "" "" ""];
    };

    "custom/gpu-usage" = {
      exec = "nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits";
      format = " {}";
      interval = 10;
      tooltip-format = "{}°C";
    };

    "custom/logo" = {
      exec = "echo ' '";
      format = "{}";
    };

    "hyprland/window" = {
      format = "  {}";
      rewrite = {
        "(.*) — Mozilla Firefox" = "$1 󰈹";
        "(.*)Steam" = "Steam 󰓓";
      };
      separate-outputs = true;
    };

    "hyprland/language" = {
      format = " {}";
      format-uk = "державна";
      format-en = "english";
      format-ru = "русский";
    };

    memory = {
      format = "󰾆 {percentage}%";
      format-alt = "󰾅 {used}GB";
      interval = 30;
      max-length = 10;
      tooltip = true;
      tooltip-format = " {used:0.1f}GB/{total:0.1f}GB";
    };

    network = {
      format-disconnected = " Disconnected";
      format-ethernet = "󱘖 Wired";
      format-linked = "󱘖 {ifname} (No IP)";
      format-wifi = "󰤨 {essid}";
      interval = 5;
      max-length = 30;
      on-click = "nm-connection-editor";
      tooltip-format = "󱘖 {ipaddr}  {bandwidthUpBytes}  {bandwidthDownBytes}";
    };

    pulseaudio = {
      format = "{icon}  {volume}%";
      format-icons = {
        car = " ";
        default = ["" "" ""];
        hands-free = "";
        headphone = "";
        headset = "";
        phone = "";
        portable = "";
      };
      format-muted = "婢 {volume}%";
      on-click = "pavucontrol -t 3";
      on-click-middle = "pamixer -t";
      on-scroll-down = "pamixer -d 5";
      on-scroll-up = "pamixer -i 5";
      scroll-step = 5;
      tooltip-format = "{icon} {desc} {volume}%";
    };

    "pulseaudio#microphone" = {
      format = "{format_source}";
      format-source = " {volume}%";
      format-source-muted = " {volume}%";
      on-click = "pavucontrol -t 4";
      on-click-middle = "pamixer --default-source -t";
      on-scroll-down = "pamixer --default-source -d 5";
      on-scroll-up = "pamixer --default-source -i 5";
      scroll-step = 5;
    };

    tray = {
      icon-size = 15;
      spacing = 5;
    };
  };
in {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
    });
    style = myCss;
    settings = {mainBar = mainWaybarConfig;};
    systemd.enable = true; # Enable systemd service
    systemd.target = "hyprland-session.target"; # Start with Hyprland
  };
}
