{
  description = "nezia's nixos configuration";

  outputs = {
    nixpkgs,
    systems,
    home-manager,
    sops-nix,
    stylix,
    treefmt-nix,
    ...
  } @ inputs: let
    username = "nezia";
    system = "x86_64-linux";
    # small tool to iterate over each systems
    eachSystem = f: nixpkgs.lib.genAttrs (import systems) (system: f nixpkgs.legacyPackages.${system});
    # eval the treefmt modules from ./treefmt.nix
    treefmtEval = eachSystem (pkgs: treefmt-nix.lib.evalModule pkgs ./treefmt.nix);

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
    formatter = eachSystem (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
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
    treefmt-nix.url = "github:numtide/treefmt-nix";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };
}
