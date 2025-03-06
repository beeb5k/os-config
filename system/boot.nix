{pkgs, ...}: {
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 50;

  # ---- Grub ----
  boot.loader.grub = {
    enable = true;
    device = "nodev"; # Use EFI mode
    efiSupport = true;
    useOSProber = true; # Enable OS detection for dual boot
    configurationLimit = 10;
    theme = pkgs.fetchFromGitHub {
      owner = "shvchk";
      repo = "fallout-grub-theme";
      rev = "80734103d0b48d724f0928e8082b6755bd3b2078";
      sha256 = "sha256-7kvLfD6Nz4cEMrmCA9yq4enyqVyqiTkVZV5y4RyUatU=";
    };
  };

  # ---- Systemd-boot ----
  /*
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 10;
  };
  */
}
