{
  self,
  inputs,
  lib,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs.lib) nixosSystem;
    homeImports = import "${self}/home/profiles";
    mod = "${self}/system";
    inherit (import mod) laptop desktop;
    specialArgs = {
      inherit inputs self;
    };
  in {
    vamos = nixosSystem {
      inherit specialArgs;
      modules =
        laptop
        ++ [
          ./vamos

          ../system/services/regreet.nix
          "${mod}/programs/niri"

          self.nixosModules.style

          {
            style = {
              gtk.enable = true;
              wallpaper = lib.mkDefault ../wallpapers/lucy-edgerunners-wallpaper.jpg;
              scheme = lib.mkDefault "catppuccin-frappe";
            };
          }
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

          "${mod}/programs/kde.nix"
          "${mod}/hardware/nvidia.nix"

          self.nixosModules.theme
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
