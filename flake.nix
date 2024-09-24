{
  description = "nezia's nixos configuration";

  outputs = {
    nixpkgs,
    home-manager,
    nixvim,
    sops-nix,
    stylix,
    ...
  } @ inputs: let
    username = "nezia";
    system = "x86_64-linux";

    commonModules = hostname: [
      ./modules
      ./hosts/common
      ./hosts/${hostname}

      sops-nix.nixosModules.sops
      stylix.nixosModules.stylix
      home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          sharedModules = [
            nixvim.homeManagerModules.nixvim
          ];
          extraSpecialArgs = {
            inherit inputs system;
          };
        };
      }
      {
        _module.args = {
          inherit hostname username;
        };
      }
    ];

    configureSystem = hostname: homeConfig:
      nixpkgs.lib.nixosSystem {
        inherit system;
        modules = commonModules hostname ++ [{home-manager.users."${username}" = import homeConfig;}];
        specialArgs = {
          inherit inputs;
        };
      };
  in {
    nixosConfigurations = {
      vamos = configureSystem "vamos" ./home/laptop;
      solaire = configureSystem "solaire" ./home/desktop;
    };
  };

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
    stylix.url = "github:danth/stylix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wezterm = {
      url = "github:wez/wezterm/main?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:MarceColl/zen-browser-flake";
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };
}
