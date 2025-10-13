{
  description = "NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    agenix.url = "github:ryantm/agenix";
  };

  outputs = { self, nixpkgs, agenix, ... } @inputs:
  {
    # NixOS configurations per machine
    nixosConfigurations = {
      wsl = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; } ;
        system = "x86_64-linux";
        modules = [
          agenix.nixosModules.default
          ./hosts/wsl.nix
          ./modules/common.nix
        ];
      };

      rpi3 = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; } ;
        system = "aarch64-linux";
        modules = [
          agenix.nixosModules.default
          ./hosts/rpi3.nix
          ./modules/common.nix
          ./modules/services/miniflux.nix
          ./modules/services/adguardhome.nix
        ];
      };
    };
  };
}