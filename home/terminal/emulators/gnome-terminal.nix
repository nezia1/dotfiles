{
  config,
  inputs,
  ...
}: {
  programs.gnome-terminal = {
    enable = true;
    showMenubar = true;
    profile = {
      "4621184a-b921-42cf-80a0-7784516606f2" = {
        default = true;
        audibleBell = false;
        allowBold = true;
        boldIsBright = true;
        visibleName = "default";
        font = "Intel One Mono 14";
        colors = let
          inherit (inputs.basix.schemeData.base16.${config.theme.scheme}) palette;
        in {
          backgroundColor = "#${palette.base00}";
          foregroundColor = builtins.trace "#${palette.base05}" "#${palette.base05}";

          palette = builtins.attrValues (builtins.mapAttrs (_: color: "#${color}") palette);
        };
      };
    };
  };
}
