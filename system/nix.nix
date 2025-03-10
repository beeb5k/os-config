{pkgs, ...}: {
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };
    # Pin nixpkgs for older Nix tools
    nixPath = ["nixpkgs=${pkgs.path}"];
  };
  environment.systemPackages = with pkgs; [nil alejandra];
}
