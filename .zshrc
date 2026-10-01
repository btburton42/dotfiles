# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme (https://github.com/ohmyzsh/ohmyzsh/wiki/Themes)
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(git asdf)

source $ZSH/oh-my-zsh.sh

# SAVEHIST=1000  # Save most-recent 1000 lines
HISTFILE=~/.zsh_history

setopt no_inc_append_history
# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#### MY STUFF


# alias docker=podman
export PODMAN_COMPOSE_PROVIDER=podman-compose

############ PROJECT SPECIFIC ############
# SPIFF
# alias cyclespiff="docker compose down spiffworkflow-backend && docker compose up -d spiffworkflow-backend"
# git pull all
gpa() {
  for dir in * ; do if [ \! -L ${dir} -a -d ${dir}/.git ] ; then (cd ${dir} ; echo ":::: ${dir} ::::"; git pull) ; fi ; done
}

# spiff-arena
export SPIFFWORKFLOW_BACKEND_DATABASE_TYPE="sqlite ./bin/recreate_db clean"

############ PROJECT SPECIFIC ############

### AUTOJUMP
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

### FUNCTIONS
# hs - repeat history
hs() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
}

# g-open - open git remote url
g-open() {
    file=${1:-""}
    git_branch=${2:-$(git symbolic-ref --quiet --short HEAD)}
    git_project_root=$(git config remote.origin.url | sed "s~git@\(.*\):\(.*\)~https://\1/\2~" | sed "s~\(.*\).git\$~\1~")
    git_directory=$(git rev-parse --show-prefix)
    open ${git_project_root}/tree/${git_branch}/${git_directory}${file}
}

### GO PATH VARS
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin

#### PATH:
export PATH=$PATH:$GOBIN
export PATH="/usr/local/sbin":$PATH
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="/Users/brendantburton/.local/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
# export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"

autoload -U add-zsh-hook

_frum_autoload_hook () {
    frum --log-level quiet local
}

### ASDF
# . /opt/homebrew/opt/asdf/libexec/asdf.sh

### PYENV
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

## for prompt updating
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
PS1='($(pyenv version-name)) '$PS1

# activate autoenv
# source '/usr/local/opt/autoenv/activate.sh'


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# Homebrew util-linux, for commands like setsid
export PATH="/opt/homebrew/opt/util-linux/bin:/opt/homebrew/opt/util-linux/sbin:$PATH"
# export PATH="$HOME/.local/bin:$PATH"

export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# dotfiles
# make sure the --git-dir is the same as the
# directory where you created the repo above.
alias config="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
