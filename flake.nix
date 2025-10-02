{
  description = "NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs, ... } @inputs:
  {
    # NixOS configurations per machine
    nixosConfigurations = {
      #wsl = nixpkgs.lib.nixosSystem {
        #system = "x86_64-linux";
        #modules = [
        #  ./hosts/wsl.nix
        #  ./modules/common.nix
        #];
      #};

      rpi3 = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; } ;
        system = "aarch64-linux";
        modules = [
          ./hosts/rpi3.nix
          ./modules/common.nix
        ];
      };
    };
  };
}