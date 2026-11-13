# Path to your Oh My Zsh installation.
# export ZSH="$HOME/.oh-my-zsh"

# Preferred editor for local and remote sessions

if [[ -n "$SSH_CONNECTION" ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# CLI
export LSCOLORS=GxFxCxDxbxegedabagaced

# Tab completion
autoload -Uz compinit
compinit

# Command history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY SHARE_HISTORY HIST_IGNORE_DUPS

# Up/down arrows search history using what you've typed so far
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward

# navigation and shit
alias l='ls'
setopt AUTO_CD
setopt AUTO_LIST        # show matches when you press Tab
setopt LIST_ROWS_FIRST  # fill across rows rather than down columns


# autojump init
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# ALIASES
alias syncpi='rsync -av pi@192.168.110.20:/home/qbtuser/Downloads/ /Users/tylerburton/Documents/rpi-sync'
alias python="python3"
alias szsh="source ~/.zshrc"

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# asdf init
export ASDF_DATA_DIR=/Users/tylerburton/.asdf
export PATH="$ASDF_DATA_DIR/shims:$PATH"

# opencode
export PATH=/Users/tylerburton/.opencode/bin:$PATH

# Pi
export PATH="/Users/tylerburton/.asdf/installs/nodejs/25.2.1/bin:$PATH"
export PATH="/Users/tylerburton/.local/bin:$PATH"

# fuzzy history
source <(fzf --zsh)
# bring in starship
eval "$(starship init zsh)"
