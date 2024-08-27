{ ... }: 

{
  programs.nixvim.autoCmd = [{
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
}
