# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob nomatch
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/tony/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats '%b '

setopt PROMPT_SUBST
PROMPT='%F{green}%n%f@%F{green}%m%f %F{blue}%~%f %F{red}${vcs_info_msg_0_}%f$ '

source ~/.zsh/antigen.zsh
source ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

antigen apply

# aliases
alias ls="ls --color=auto"
alias ll="ls -al"

# Set up Node Version Manager
source /usr/share/nvm/init-nvm.sh
