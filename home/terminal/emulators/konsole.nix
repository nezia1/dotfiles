{
  lib,
  config,
  inputs,
  ...
}: {
  programs.konsole = {
    enable = true;
    defaultProfile = "default";
    profiles = {
      default = {
        font = {
          name = "monospace";
          size = 14;
        };
      };
    };

    extraConfig = {
      "MainWindow" = {
        "MenuBar" = "Disabled";
        "ToolBarsMovable" = "Disabled";
      };
      "KonsoleWindow" = {
        "ShowMenuBarByDefault" = "false";
      };
    };
  };
}
