{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs.lib) nixosSystem;
    homeImports = import "${self}/home/profiles";
    mod = "${self}/system";
    inherit (import mod) laptop desktop;
    specialArgs = {
      inherit inputs self;
      inherit (inputs) nix-colors;
    };
  in {
    vamos = nixosSystem {
      inherit specialArgs;
      modules =
        laptop
        ++ [
          ./vamos

          "${mod}/programs/gnome.nix"

          {
            home-manager = {
              users.nezia.imports = homeImports.vamos;
              extraSpecialArgs = specialArgs;
            };
          }

          inputs.nixos-hardware.nixosModules.framework-13-7040-amd
        ];
    };

    solaire = nixosSystem {
      inherit specialArgs;
      modules =
        desktop
        ++ [
          ./solaire

          "${mod}/programs/gnome.nix"
          "${mod}/hardware/nvidia.nix"

          {
            home-manager = {
              users.nezia.imports = homeImports.solaire;
              extraSpecialArgs = specialArgs;
            };
          }
        ];
    };
  };
}
