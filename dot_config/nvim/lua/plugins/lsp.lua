-- lua/plugins/lsp.lua

-- COQ settings
vim.g.coq_settings = { auto_start = 'shut-up' }
local coq = require "coq"

-- Function to get root directory
local function get_root_dir(fname, patterns)
  local dir = vim.fs.dirname(fname)
  for _, pattern in ipairs(patterns) do
    local match = vim.fn.globpath(dir, pattern)
    if match ~= "" then
      return dir
    end
  end
  return nil
end

-- Table to store server configurations
local servers = {
  gopls = {
    cmd = { "gopls" },
    patterns = { "go.mod", "go.work", ".git" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    },
  },
  tsserver = {
    cmd = { "typescript-language-server", "--stdio" },
    patterns = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
    settings = {
      javascript = {
        inlayHints = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
        },
      },
      typescript = {
        inlayHints = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
        },
      },
    },
  },
}

-- Function to start LSP
local function start_lsp(server_name, config)
  vim.api.nvim_create_autocmd("FileType", {
    pattern = config.filetypes,
    callback = function(args)
      local bufnr = args.buf
      local client = vim.lsp.get_active_clients({name = server_name, bufnr = bufnr})[1]
      if client then return end

      local root_dir = get_root_dir(vim.api.nvim_buf_get_name(bufnr), config.patterns)
      if root_dir then
        vim.lsp.start(coq.lsp_ensure_capabilities({
          name = server_name,
          cmd = config.cmd,
          root_dir = root_dir,
          settings = config.settings,
          filetypes = config.filetypes,
        }))
      end
    end,
  })
end

-- Start LSP for each configured server
for server_name, config in pairs(servers) do
  start_lsp(server_name, config)
end

-- Additional LSP setup (optional)
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
