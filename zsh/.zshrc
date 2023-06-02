# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob nomatch
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/nezia/.zshrc'

autoload -U promptinit; promptinit
autoload -Uz compinit

compinit
# End of lines added by compinstall
autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats '%b '

setopt PROMPT_SUBST
PROMPT='%F{green}%n%f@%F{green}%m%f %F{blue}%~%f %F{red}${vcs_info_msg_0_}%f$ '

# aliases
alias ls="ls --color=auto"
alias ll="ls -al"


# Lazy-load antidote and generate the static load file only when needed
zsh_plugins=${ZDOTDIR:-$HOME}/.zsh_plugins
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
	(
		source $HOME/.antidote/antidote.zsh
		antidote bundle <${zsh_plugins}.txt >${zsh_plugins}.zsh
	)
fi
source ${zsh_plugins}.zsh

eval $(keychain --eval --quiet id_ed25519)
