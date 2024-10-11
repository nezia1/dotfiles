{
  inputs,
  pkgs,
  config,
  ...
}: let
  cfg = config.programs.ags;
in {
  imports = [inputs.ags.homeManagerModules.default];

  home.packages = with pkgs; [
    libdbusmenu-gtk3
    dart-sass
  ];

  programs.ags = {
    enable = true;

    # null or path, leave as null if you don't want hm to manage the config
    configDir = ./.;

    # additional packages to add to gjs's runtime
    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
    ];
  };
  systemd.user.services.ags = {
    Unit = {
      Description = "Aylur's Gtk Shell";
      PartOf = [
        "graphical-session.target"
      ];
    };
    Service = {
      ExecStart = "${cfg.package}/bin/ags";
      Restart = "on-failure";
    };
    Install.WantedBy = ["graphical-session.target"];
  };
}
