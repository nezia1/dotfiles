{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) getExe;
in {
  programs.helix = {
    enable = true;
    settings = {
      theme = "catppuccin_macchiato";
      editor = {
        line-number = "relative";
        lsp.display-messages = true;
        auto-format = true;
        auto-completion = true;
        completion-timeout = 5;
      };
      keys.normal = {
        space = {
          space = "file_picker";
          w = ":w";
          q = ":q";
        };
        esc = ["collapse_selection" "keep_primary_selection"];
      };
    };

    languages = {
      language = [
        {
          name = "nix";
          formatter = {command = getExe pkgs.alejandra;};
        }
      ];
    };
  };
  home.packages = [
    pkgs.nil
  ];
}
