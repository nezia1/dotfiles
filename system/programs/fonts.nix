{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-emoji
      intel-one-mono
      (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
    ];
    enableDefaultPackages = false;

    fontconfig.defaultFonts = let
      addAll = builtins.mapAttrs (_: v: ["Symbols Nerd Font"] ++ v ++ ["Noto Color Emoji"]);
    in
      addAll {
        serif = ["Noto Serif"];
        sansSerif = ["Inter"];
        monospace = ["Intel One Mono"];
        emoji = [];
      };
  };
}
