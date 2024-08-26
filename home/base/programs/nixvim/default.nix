{ ... }:

{
  programs.nixvim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    colorschemes.catppuccin = {
      enable = true;
      settings = { flavour = "frappe"; };
    };

    performance.byteCompileLua.enable = true;

    clipboard.providers.wl-copy.enable = true;

    globals.mapleader = " ";

    opts = { 
      smartindent = false;
      relativenumber = true;
      clipboard = "unnamedplus";
    };

    files = {
      "ftplugin/nix.lua" = {
        opts = {
          expandtab = true;
          shiftwidth = 2;
          tabstop = 2;
        };
      };
    };

    autoCmd = [{
      event = [ "BufWritePre" ];

      callback = {
        __raw = ''
          function()
            vim.lsp.buf.format { async = false }
          end
          '';
      };

      desc = "Auto format buffer before save using LSP";
    }];
    keymaps = [
      {
        action = "<cmd>Telescope find_files<CR>";
        key = "<leader>ff";
        options = {
          desc = "Find files";
        };
      }
      {
        action = "<cmd>Telescope projects<CR>";
        key = "<leader>fp";
        options = {
          desc = "Find projects";
        };
      }
      {
        action = "<cmd>Neotree toggle<CR>";
        key = "<leader>ft";
        options = {
          desc = "Toggle neo-tree";
        };
      }      
      {
        action = ''
          <cmd>lua vim.lsp.buf.code_action({ apply = true })<CR>
        '';
        key = "<leader>lc";
        options = {
          desc = "Apply code actions";
        };
      }
      {
        action = ''
          <cmd>lua vim.lsp.buf.format()<CR>
        '';
        key = "<leader>lf";
        options = {
          desc = "Format buffer";
        };
      }
    ];

    plugins = {
      alpha = {
        enable = true;
        layout = [
          {
            type = "padding";
            val = 2;
          }
          {
            opts = {
              hl = "Keyword";
              position = "center";
            };
            type = "text";
            val = [
              "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⡀⠒⠒⠦⣄⡀⠀⠀⠀⠀⠀⠀⠀"
              "⠀⠀⠀⠀⠀⢀⣤⣶⡾⠿⠿⠿⠿⣿⣿⣶⣦⣄⠙⠷⣤⡀⠀⠀⠀⠀"
              "⠀⠀⠀⣠⡾⠛⠉⠀⠀⠀⠀⠀⠀⠀⠈⠙⠻⣿⣷⣄⠘⢿⡄⠀⠀⠀"
              "⠀⢀⡾⠋⠀⠀⠀⠀⠀⠀⠀⠀⠐⠂⠠⢄⡀⠈⢿⣿⣧⠈⢿⡄⠀⠀"
              "⢀⠏⠀⠀⠀⢀⠄⣀⣴⣾⠿⠛⠛⠛⠷⣦⡙⢦⠀⢻⣿⡆⠘⡇⠀⠀"
              "⠀⠀⠀⠀⡐⢁⣴⡿⠋⢀⠠⣠⠤⠒⠲⡜⣧⢸⠄⢸⣿⡇⠀⡇⠀⠀"
              "⠀⠀⠀⡼⠀⣾⡿⠁⣠⢃⡞⢁⢔⣆⠔⣰⠏⡼⠀⣸⣿⠃⢸⠃⠀⠀"
              "⠀⠀⢰⡇⢸⣿⡇⠀⡇⢸⡇⣇⣀⣠⠔⠫⠊⠀⣰⣿⠏⡠⠃⠀⠀⢀"
              "⠀⠀⢸⡇⠸⣿⣷⠀⢳⡈⢿⣦⣀⣀⣀⣠⣴⣾⠟⠁⠀⠀⠀⠀⢀⡎"
              "⠀⠀⠘⣷⠀⢻⣿⣧⠀⠙⠢⠌⢉⣛⠛⠋⠉⠀⠀⠀⠀⠀⠀⣠⠎⠀"
              "⠀⠀⠀⠹⣧⡀⠻⣿⣷⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⡾⠃⠀⠀"
              "⠀⠀⠀⠀⠈⠻⣤⡈⠻⢿⣿⣷⣦⣤⣤⣤⣤⣤⣴⡾⠛⠉⠀⠀⠀⠀"
              "⠀⠀⠀⠀⠀⠀⠈⠙⠶⢤⣈⣉⠛⠛⠛⠛⠋⠉⠀⠀⠀⠀⠀⠀⠀⠀"
              "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
            ];
          }
          {
            type = "padding";
            val = 2;
          }
          {
            type = "group";
            val = let
              mkButton = shortcut: cmd: val: hl: {
                type = "button";
                inherit val;
                opts = {
                  inherit hl shortcut;
                  keymap = [ "n" shortcut cmd { } ];
                  position = "center";
                  cursor = 0;
                  width = 40;
                  align_shortcut = "right";
                  hl_shortcut = "Keyword";
                };
              };
            in [
              (mkButton "f" "<CMD>:Telescope find_files<CR>" "  Find File"
                "Operator")
              (mkButton "p" "<CMD>:Telescope projects<CR>" "  Projects"
                "Operator")
              (mkButton "q" "<CMD>qa<CR>" "󰈆  Quit" "Error")
            ];
          }
        ];
      };
      lualine = {
        enable = true;
        extensions = [ "neo-tree" ];
        globalstatus = true;
      };
      treesitter = {
        enable = true;
        settings = {
          auto_install = true;
          highlight = {
            additional_vim_regex_highlighting = true;
            custom_captures = { };
            enable = true;
          };
          incremental_selection = {
            enable = true;
            keymaps = {
              init_selection = false;
              node_decremental = "grm";
              node_incremental = "grn";
              scope_incremental = "grc";
            };
          };
          indent = {
            enable = true;
          };
          parser_install_dir = {
            __raw = "vim.fs.joinpath(vim.fn.stdpath('data'), 'treesitter')";
          };
        };
      };
      treesitter-context.enable = true;
      indent-blankline.enable = true;
      lsp = {
        enable = true;
        servers = {
          gopls.enable = true;
          nixd.enable = true;
          lua-ls.enable = true;
        };
      };
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-e>" = "cmp.mapping.close()";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<S-Tab>" =
              "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          };

          sources =
            [ { name = "nvim_lsp"; } { name = "path"; } { name = "buffer"; } ];
        };
      };
      cmp-nvim-lsp.enable = true;
      cmp-nvim-lsp-signature-help.enable = true;
      telescope = {
        enable = true;
      };

      neo-tree = {
        enable = true;
        useDefaultMappings = true;
      };

      nvim-autopairs.enable = true;

      project-nvim = {
        enable = true;
        enableTelescope = true;
      };

      which-key = {
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
              group = "Find";
            }
            {
              __unkeyed = "<leader>l";
              group = "LSP";
            }
          ];
        };
      };
      tmux-navigator.enable = true;
    };
  };
}
