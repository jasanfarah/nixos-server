{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
    disko = {
      url = "github:nix-community/disko";
      inputs = { nixpkgs = { follows = "nixpkgs"; }; };
    };
  };

  outputs = { self, nixpkgs, disko }: {

    nixosConfigurations = {
      server = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./server/configuration.nix disko.nixosModules.disko ];
      };
    };
  };
}

