{pkgs, ...}: {
  programs.zathura = {
    enable = true;
    options = {
      font = "Inter 12";
      selection-notification = true;

      selection-clipboard = "clipboard";
      adjust-open = "best-fit";
      pages-per-row = "1";
      scroll-page-aware = "true";
      scroll-full-overlap = "0.01";
      scroll-step = "100";
      zoom-min = "10";
    };

    extraConfig = "include catppuccin-frappe";
  };
  xdg.configFile = {
    "zathura/catppuccin-frappe".source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/zathura/main/src/catppuccin-frappe";
      hash = "sha256-xdWI/Ai3iE0zRF/9DCxILKmVaNWbfqHm7Xeh6eKM3MY=";
    };
  };
}
