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
