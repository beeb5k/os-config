{
  description = "Main flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    stylix.url = "github:danth/stylix/release-24.11";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
    lzextras.url = "github:BirdeeHub/lzextras";

    home-manager = {
      url = "github:nix-community/home-manager?ref=release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    stylix,
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
    nixosConfigurations.dixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs;};
      modules = [./nixos/configuration.nix];
    };
    homeConfigurations."beeb5k" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [stylix.homeManagerModules.stylix ./home/home.nix];

      extraSpecialArgs = {inherit inputs unstable;};
    };
  };
}
