{pkgs, ...}: {
  programs = {
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      extraCompatPackages = [
        pkgs.proton-ge-bin
      ];
    };
    gamemode.enable = true;
    coolercontrol = {
      enable = true;
      nvidiaSupport = true;
    };
  };
}
