if test -f /proc/sys/fs/binfmt_misc/WSLInterop andtest -f /proc/sys/fs/binfmt_misc/WSLInterop; and status is-interactive 
   keychain --quiet -Q id_ed25519 
end

if test -f ~/.keychain/$hostname-fish
	source ~/.keychain/$hostname-fish
end

set -g fish_greeting

# Created by `pipx` on 2023-08-28 08:41:19
set PATH $PATH /home/nezia/.local/bin

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
