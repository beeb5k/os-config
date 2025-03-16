{
  description = "Main flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager?ref=release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {allowUnfree = true;};
    };

    unstable = import nixpkgs-unstable {
      inherit system;
      config = {allowUnfree = true;};
    };
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs;};
      modules = [./configuration.nix];
    };
    homeConfigurations."beeb5k" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [./home.nix];

      extraSpecialArgs = {inherit inputs unstable;};
    };
  };
}
