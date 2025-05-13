{
  inputs = { nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11"; };

  outputs = { self, nixpkgs }: {

    nixosConfigurations = {
      server = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./server/configuration.nix ];
      };
    };
  };
}

