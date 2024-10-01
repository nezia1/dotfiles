{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-emoji
      intel-one-mono
      (nerdfonts.override {fonts = ["IntelOneMono"];})
    ];
    enableDefaultPackages = false;

    fontconfig.defaultFonts = {
      serif = ["Noto Serif"];
      sansSerif = ["Inter"];
      monospace = ["IntoneMono NF"];
      emoji = ["Noto Color Emoji"];
    };
  };
}
