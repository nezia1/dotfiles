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
      url = "path:shells";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nixvim, sops-nix, stylix, ... }@inputs: 
    let
      username = "nezia";
      system = "x86_64-linux";

      commonModules = hostname: [
        ./modules/sops.nix
        ./modules/system.nix 
        ./modules/gnome.nix
        ./modules/syncthing
        ./modules/stylix.nix
        ./hosts/${hostname}
        sops-nix.nixosModules.sops
        stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.sharedModules = [ nixvim.homeManagerModules.nixvim ];
          home-manager.extraSpecialArgs = { inherit inputs; };
        }
        { _module.args = { inherit hostname username; }; }
      ];

      configureSystem = hostname: homeConfig: nixpkgs.lib.nixosSystem {
        system = system;
        modules = commonModules hostname ++ [
          { home-manager.users.${username} = import homeConfig; }
        ];
      };
    in {
      nixosConfigurations = {
        vamos = configureSystem "vamos" ./home/laptop;
        solaire = configureSystem "solaire" ./home/desktop;
      };
    };
}
