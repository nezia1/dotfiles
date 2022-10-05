curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
for plugin in (cat fisher_plugins)
	fisher install $plugin
end

fish nord.fish
