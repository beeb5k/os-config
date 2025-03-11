{pkgs, ...}: {
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
    };

    # Pin nixpkgs for older Nix tools
    nixPath = ["nixpkgs=${pkgs.path}"];
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 2";
    flake = "/home/beeb5k/nixos-config";
  };

  environment.systemPackages = with pkgs; [nixd alejandra];
}
