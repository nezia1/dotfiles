let
  common = [
    ./core
    ./hardware/printing.nix
    ./hardware/fwupd.nix

    ./network

    ./programs

    ./services
  ];
  desktop =
    common
    ++ [
      ./hardware/uni-sync.nix
    ];

  laptop =
    common
    ++ [
      ./hardware/power.nix
      ./hardware/fprintd.nix
      ./services/keyd.nix
    ];
in {
  inherit desktop laptop;
}
