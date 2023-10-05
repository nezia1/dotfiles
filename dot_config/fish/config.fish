if status is-interactive 
   keychain --quiet -Q id_ed25519 
end

if test -f ~/.keychain/$hostname-fish
	source ~/.keychain/$hostname-fish
end

set -g fish_greeting

# Created by `pipx` on 2023-08-28 08:41:19
set PATH $PATH /home/nezia/.local/bin
