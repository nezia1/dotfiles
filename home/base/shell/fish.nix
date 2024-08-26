{ pkgs,  ... }:

  {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      fish_vi_key_bindings # Enable Vi mode

      function fzf --wraps=fzf --description="Use fzf-tmux if in tmux session"
      if set --query TMUX
        fzf-tmux $argv
      else
        command fzf $argv
      end
    end
    '';
    shellAbbrs = { cd = "z"; ngc = "sudo nix-collect-garbage -d"; };
    plugins = [ { name = "fzf"; src = pkgs.fishPlugins.fzf.src; } ];
  };
}

