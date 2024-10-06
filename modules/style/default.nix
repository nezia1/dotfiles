{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkOption;
  inherit (lib.types) string path package;
in {
  imports = [./gtk.nix];
  options.style = {
    scheme = mkOption {
      description = ''
        Name of the tinted-scheming color scheme to use.
      '';
      type = string;
      example = lib.literalExpression "catppuccin-frappe";
    };
    wallpaper = mkOption {
      description = ''
        Location of the wallpaper that will be used throughout the system.
      '';
      type = path;
      example = lib.literalExpression "./wallpaper.png";
    };

    cursorTheme = {
      name = mkOption {
        description = ''
          Name of the cursor theme.
        '';
        default = "Bibata-Modern-Classic";
      };
      package = mkOption {
        type = package;
        description = ''
          Package providing the cursor theme.
        '';
        default = pkgs.bibata-cursors;
      };
      size = mkOption {
        description = ''
          Size of the cursor.
        '';
        default = 24;
      };
    };
  };
}
