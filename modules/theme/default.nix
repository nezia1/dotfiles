{lib, ...}: {
  options.theme = {
    scheme = lib.mkOption {
      description = ''
        Name of the tinted-scheming color scheme to use.
      '';
      type = lib.types.string;
      example = lib.literalExpression "catppuccin-frappe";
    };
    wallpaper = lib.mkOption {
      description = ''
        Location of the wallpaper that will be used throughout the system.
      '';
      type = lib.types.path;
      example = lib.literalExpression "./wallpaper.png";
    };
  };
}
