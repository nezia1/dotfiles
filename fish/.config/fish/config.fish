# powerline initialization
set fish_function_path $fish_function_path "/usr/share/powerline/bindings/fish"
source /usr/share/powerline/bindings/fish/powerline-setup.fish
powerline-setup

# setup keychain
eval (keychain --eval --agents ssh -Q --quiet ssh id_ed25519 --nogui)

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
