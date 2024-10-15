{pkgs, ...}: {
  services.kmscon = {
    enable = true;
    fonts = [
      {
        name = "IntoneMono NF";
        package = pkgs.nerdfonts.override {fonts = ["IntelOneMono"];};
      }
    ];
    extraConfig = ''
      font-size=14
      font-dpi=144
    '';
  };
}
