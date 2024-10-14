{self, ...}: {
  imports = [
    "${self}/home/services/udiskie.nix"

    "${self}/home/programs"

    "${self}/home/programs/niri"
    "${self}/home/programs/ags"
    "${self}/home/programs/fuzzel.nix"
    "${self}/home/programs/swaybg.nix"
    "${self}/home/programs/swaylock.nix"
    "${self}/home/programs/swayidle.nix"

    "${self}/home/terminal/emulators/foot.nix"

    "${self}/home/programs/editors/neovim.nix"
    "${self}/home/programs/editors/helix.nix"
  ];
}
