{pkgs, ...}: {
  imports = [./nixpkgs.nix ./nh.nix];
  environment.systemPackages = [pkgs.git];
  nix = {
    package = pkgs.lix;
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
}
