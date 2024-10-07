{pkgs, ...}: {
  programs.chromium.enable = true;
  programs.firefox = let
    betterfox = pkgs.fetchFromGitHub {
      owner = "yokoffing";
      repo = "betterfox";
      rev = "e026ed7d3a763c5d3f96c2680d7bc3340831af4f";
      hash = "sha256-hpkEO5BhMVtINQG8HN4xqfas/R6q5pYPZiFK8bilIDs=";
    };
  in {
    enable = true;
    profiles = {
      nezia = {
        search = {
          engines = {
            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@np"];
            };
            "NixOS Wiki" = {
              urls = [{template = "https://wiki.nixos.org/w/index.php?search={searchTerms}";}];
              iconUpdateURL = "https://wiki.nixos.org/favicon.ico";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = ["@nw"];
            };
            "Home Manager Option Search" = {
              urls = [{template = "https://home-manager-options.extranix.com/?release=master&query={searchTerms}";}];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@hm"];
            };
            "Arch Wiki" = {
              urls = [{template = "https://wiki.archlinux.org/index.php?search={searchTerms}";}];
              icon = "https://archlinux.org/favicon.ico";
              definedAliases = ["@aw"];
            };
            "Google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
          };
        };
        # stolen from https://github.com/oddlama/nix-config/blob/main/users/myuser/graphical/firefox.nix#L53-L57
        extraConfig = builtins.concatStringsSep "\n" [
          (builtins.readFile "${betterfox}/Securefox.js")
          (builtins.readFile "${betterfox}/Fastfox.js")
          (builtins.readFile "${betterfox}/Peskyfox.js")
          (builtins.readFile "${betterfox}/Smoothfox.js")
        ];
        isDefault = true;
      };
    };
  };
}
