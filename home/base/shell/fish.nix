{ pkgs,  ... }:

  {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      fish_vi_key_bindings # Enable Vi mode
      fish_config theme choose "Catppuccin Frappe"
    '';
    shellAbbrs = { cd = "z"; ngc = "sudo nix-collect-garbage -d"; };
    plugins = [ { name = "fzf"; src = pkgs.fishPlugins.fzf.src; } ];
  };
  # Fetch the Catppuccin theme
  xdg.configFile."fish/themes/Catppuccin Frappe.theme".source = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "fish";
    rev = "a3b9eb5eaf2171ba1359fe98f20d226c016568cf";
    sha256 = "sha256-shQxlyoauXJACoZWtRUbRMxmm10R8vOigXwjxBhG8ng=";
  } + "/themes/Catppuccin Frappe.theme";

}

