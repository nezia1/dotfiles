require("core.autocmds")
require("core.options")
require("config.lazy")

if vim.g.neovide then
	require("core.neovide")
end
