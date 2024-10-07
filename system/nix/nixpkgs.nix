{pkgs, ...}: {
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      (_: prev: {
        lib =
          prev.lib
          // import ../../lib {
            inherit (prev) lib pkgs;
          };
      })
    ];
    config.permittedInsecurePackages = ["cinny-4.2.1" "cinny-unwrapped-4.2.1"];
  };
}
