{
  description = "nezia's nixos configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    shells = {
      url = "path:./shells";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nixvim, sops-nix, shells, ... }@inputs: 
    let
      username = "nezia";
      system = "x86_64-linux";

      commonModules = hostname: [
        ./hosts/${hostname}
        sops-nix.nixosModules.sops
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.sharedModules = [ nixvim.homeManagerModules.nixvim ];
          home-manager.extraSpecialArgs = { inherit inputs; };
        }
        { _module.args = { inherit hostname username; }; }
      ];
    in {
      nixosConfigurations = {
        vamos = 
          let hostname = "vamos";
          in nixpkgs.lib.nixosSystem {
              system = system;
              modules = commonModules hostname ++ [
                { home-manager.users.nezia = import ./home/laptop; }
              ];
            };

        solaire = let
          hostname = "solaire";
        in nixpkgs.lib.nixosSystem {
            system = system;
            modules = commonModules hostname ++ [
              { home-manager.users.nezia = import ./home/desktop; }
            ];
          };
      };
    };
}
