{ ... }:

{
  programs.nixvim.plugins.which-key = {
    enable = true;
    settings = {
      delay = 200;
      expand = 1;
      notify = false;
      preset = false;
      replace = {
        desc = [
          [ "<space>" "SPACE" ]
          [ "<leader>" "SPACE" ]
          [ "<[cC][rR]>" "RETURN" ]
          [ "<[tT][aA][bB]>" "TAB" ]
          [ "<[bB][sS]>" "BACKSPACE" ]
        ];
      };
      spec = [
        {
          __unkeyed = "<leader>f";
          group = "Telescope";
        }
        {
          __unkeyed = "<leader>l";
          group = "LSP";
        }
      ];
    };
  };
}
