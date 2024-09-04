{ pkgs,  ... }:

let
  catppuccin-fish = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "fish";
    rev = "a3b9eb5eaf2171ba1359fe98f20d226c016568cf";
    hash = "sha256-shQxlyoauXJACoZWtRUbRMxmm10R8vOigXwjxBhG8ng=";
  };
in
  {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      fish_vi_key_bindings # Enable Vi mode
      fish_config theme choose "Catppuccin Frappe"

      set --global hydro_fetch true
      set --global hydro_multiline true
      set --global hydro_color_pwd blue
      set --global hydro_color_git yellow
      set --global hydro_color_error red
      set --global hydro_color_prompt magenta
      set --global hydro_color_duration cyan
    '';
    shellAbbrs = { cd = "z"; ngc = "sudo nix-collect-garbage -d"; };
    plugins = [ 
      { name = "fzf"; src = pkgs.fishPlugins.fzf.src; }
      { name = "hydro"; src = pkgs.fishPlugins.hydro.src; }
    ];
  };

  programs.bash = {
    enable = true;
    initExtra = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  xdg.configFile."fish/themes/Catppuccin Frappe.theme".source = "${catppuccin-fish}/themes/Catppuccin Frappe.theme";
}

