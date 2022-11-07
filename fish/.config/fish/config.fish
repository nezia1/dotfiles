# setup keychain
# eval (keychain --eval --agents ssh -Q --quiet ssh id_ed25519 --nogui)

# wsl related config
set wsl_version_name (uname -r | sed -E 's/^.*(Microsoft|microsoft-standard).*$/\1/')
if test -n $wsl_version_name
	# if wslg is not present, set the DISPLAY variable to work with external X servers
	if ! test -d /mnt/wlsg 
		or test -z (ls -A /mnt/wslg)
		set -Ux DISPLAY (grep -m 1 nameserver /etc/resolv.conf | awk '{print $2}'):0
		set -Ux LIBGL_ALWAYS_REDIRECT 1
	end
end

# Aliases
if [ -f $HOME/.config/fish/alias.fish ]
source $HOME/.config/fish/alias.fish
end
