if status is-interactive
   keychain --quiet -Q id_ed25519 
end

if test -f ~/.keychain/$hostname-fish
	source ~/.keychain/$hostname-fish
end
