{
  self,
  pkgs,
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

          ({pkgs, ...}: {
            style = let
              wallpaper = pkgs.fetchurl {
                url = "https://github.com/NixOS/nixos-artwork/blob/master/wallpapers/nixos-wallpaper-catppuccin-macchiato.png?raw=true";
                hash = "sha256-SkXrLbHvBOItJ7+8vW+6iXV+2g0f8bUJf9KcCXYOZF0=";
              };
            in {
              gtk.enable = true;
              inherit wallpaper;
            };
          })
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
