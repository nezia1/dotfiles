{
  lib,
  config,
  ...
}: {
  options.theme = {
    wallpaper = lib.mkOption {
      description = ''
        Location of the wallpaper that will be used throughout the system.
      '';
      type = lib.types.path;
      example = lib.literalExpression "./wallpaper.png";
    };
  };
}
