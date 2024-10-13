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
    };
  in {
    vamos = nixosSystem {
      inherit specialArgs;
      modules =
        laptop
        ++ [
          ./vamos

          "${mod}/services/regreet.nix"
          "${mod}/programs/niri"
          "${mod}/services/gnome.nix"

          self.nixosModules.style

          ({pkgs, ...}: {
            style = let
              wallpaper = pkgs.fetchurl {
                url = "https://github.com/NixOS/nixos-artwork/blob/master/wallpapers/nixos-wallpaper-catppuccin-frappe.png?raw=true";
                hash = "sha256-wtBffKK9rqSJo8+7Wo8OMruRlg091vdroyUZj5mDPfI=";
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

          "${mod}/services/regreet.nix"
          "${mod}/programs/niri"
          "${mod}/services/gnome.nix"

          "${mod}/hardware/nvidia.nix"
          "${mod}/programs/games.nix"

          self.nixosModules.style
          {
            style = {
              gtk.enable = true;
              wallpaper = ../wallpapers/lucy-edgerunners-wallpaper.jpg;
            };
          }
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
