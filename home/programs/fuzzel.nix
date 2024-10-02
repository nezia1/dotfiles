{
  lib,
  pkgs,
  ...
}: {
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = lib.getExe pkgs.foot;
      };
    };
  };
}
