{ ... }:
{
  programs.nixvim = {
    plugins = {
      treesitter = {
        enable = true;
        settings = {
          auto_install = true;
          highlight = {
            additional_vim_regex_highlighting = true;
            custom_captures = { };
            enable = true;
          };
          indent = {
            enable = true;
          };
          folding = true;
          parser_install_dir = {
            __raw = "vim.fs.joinpath(vim.fn.stdpath('data'), 'treesitter')";
          };
        };
      };
      treesitter-context = {
        enable = true;
        settings = {
          line_numbers = true;
          max_lines = 0;
          min_window_height = 0;
          mode = "cursor";
          multiline_threshold = 5;
          separator = "-";
          trim_scope = "inner";
          zindex = 20;
        };
      };

      indent-blankline = {
        enable = true;
        settings = 
          {
            exclude = {
              buftypes = [
                "terminal"
                "quickfix"
              ];
              filetypes = [
                ""
                "checkhealth"
                "help"
                "lspinfo"
                "packer"
                "TelescopePrompt"
                "TelescopeResults"
                "yaml"
              ];
            };
            indent = {
              char = "│";
            };
            scope = {
              show_end = false;
              show_exact_scope = true;
              show_start = false;
            };
          };
      };
      lsp = {
        enable = true;
        servers = {
          gopls.enable = true;
          nixd.enable = true;
          lua-ls.enable = true;
          clangd.enable = true;
        };
        keymaps = {
          lspBuf = {
            K = "hover";
            gr = {
              action = "references";
              desc = "Go to references"; 
            };
            gi = { 
              action = "implementation";
              desc = "Go to implementation";
            };
            gt = {
              action = "type_definition";
              desc = "Go to type definition";
            };
          };
          extra = [
            {
              action = "<CMD>LspStop<Enter>";
              key = "<leader>lx";
              options = {
                desc = "Stop LSP";
              };
            }
            {
              action = "<CMD>LspStart<Enter>";
              key = "<leader>ls";
              options = {
                desc = "Start LSP";
              };
            }
            {
              action = "<CMD>LspRestart<Enter>";
              key = "<leader>lr";
              options = {
                desc = "Restart LSP";
              };
            }
            {
              action = "<CMD>Telescope lsp_definitions<Enter>";
              key = "gd";
              options = {
                desc = "Go to definitions";
              };
            }
          ];
        };
        postConfig = ''
          local pmenu_bg = vim.api.nvim_get_hl_by_name("Pmenu", true).background
          local pmenu_fg = vim.api.nvim_get_hl_by_name("Pmenu", true).foreground

          vim.api.nvim_set_hl(0, "NormalFloat", { bg = pmenu_bg, fg = pmenu_fg })
          vim.api.nvim_set_hl(0, "FloatBorder", { bg = pmenu_bg, fg = pmenu_fg })
          '';
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
            "<S-Tab>" = ''
              cmp.mapping(function (fallback)
                local luasnip = require('luasnip')
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, {'i', 's'})
            '';
            "<Tab>" = ''
              cmp.mapping(function (fallback)
                local luasnip = require('luasnip')
                if luasnip.expandable() then
                    luasnip.expand()
                elseif cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.jumpable(1) then
                    luasnip.jump(1)
                else
                    fallback()
                end
              end, {'i', 's'})
            '';
          };

          sources =
            [ { name = "nvim_lsp"; } { name = "path"; } { name = "buffer"; } { name = "luasnip"; } ];
        };
      };
      cmp-nvim-lsp.enable = true;
      cmp-nvim-lsp-signature-help.enable = true;
      telescope = {
        enable = true;
      };

      luasnip.enable = true;
      friendly-snippets.enable = true;
    };
  };
}
