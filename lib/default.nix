{
  pkgs,
  lib,
  ...
}: let
  # Helper function to convert hex color to decimal RGB values
  hexToDec = v: let
    hexToInt = {
      "0" = 0;
      "1" = 1;
      "2" = 2;
      "3" = 3;
      "4" = 4;
      "5" = 5;
      "6" = 6;
      "7" = 7;
      "8" = 8;
      "9" = 9;
      "a" = 10;
      "b" = 11;
      "c" = 12;
      "d" = 13;
      "e" = 14;
      "f" = 15;
      "A" = 10;
      "B" = 11;
      "C" = 12;
      "D" = 13;
      "E" = 14;
      "F" = 15;
    };
    chars = lib.strings.stringToCharacters v;
    charsLen = builtins.length chars;
  in
    lib.lists.foldl (a: v: a + v) 0
    (lib.lists.imap0 (k: v: hexToInt."${v}" * (pow 16 (charsLen - k - 1))) chars);

  # Power function for exponentiation
  pow = let
    pow' = base: exponent: value:
      if exponent == 0
      then 1
      else if exponent <= 1
      then value
      else pow' base (exponent - 1) (value * base);
  in
    base: exponent: pow' base exponent base;

  # Converts hex color to KDE color format
  colorToKde = name: hexColor: let
    r = hexToDec (builtins.substring 0 2 hexColor);
    g = hexToDec (builtins.substring 2 2 hexColor);
    b = hexToDec (builtins.substring 4 2 hexColor);
  in "[${name}]\nColor=${toString r},${toString g},${toString b}\n";

  # Mapping base16 colors to KDE color scheme sections
  schemeToKonsole = scheme: let
    inherit (scheme) palette;

    colorMap = {
      base00 = ["Background" "BackgroundFaint" "BackgroundIntense"];
      base01 = ["Color0"];
      base02 = ["Color0Intense"];
      base04 = ["Color4"];
      base05 = ["Foreground" "ForegroundFaint" "ForegroundIntense"];
      base06 = ["Color7"];
      base07 = ["Color7Intense"];
      base08 = ["Color1" "Color1Intense"];
      base09 = ["Color1Intense"];
      base0A = ["Color3" "Color3Intense"];
      base0B = ["Color2" "Color2Intense"];
      base0C = ["Color6" "Color6Intense"];
      base0D = ["Color4" "Color4Intense"];
      base0E = ["Color5" "Color5Intense"];
    };

    # Generate KDE color sections using the mapped colors
    colorSections = lib.concatStringsSep "\n" (lib.attrsets.mapAttrsToList
      (
        name: value:
          lib.concatMapStrings (slot: colorToKde slot value) (colorMap.${name} or [])
      )
      palette);
  in
    lib.strings.concatStringsSep "\n" (
      [
        "[General]"
        "\nDescription=${scheme.name}"
        "\nOpacity=1"
        "\nWallpaper="
      ]
      ++ [colorSections]
    );

  # Main function to create the KDE colorscheme file
  mkKonsoleColorScheme = scheme:
    pkgs.writeText "${scheme.name}.colorscheme" (schemeToKonsole scheme);
in {inherit mkKonsoleColorScheme;}
