# Path to your oh-my-zsh installation.
if [ -d $HOME/.oh-my-zsh ]; then
  export ZSH=$HOME/.oh-my-zsh
fi

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

if [ -f $ZSH/oh-my-zsh.sh ]; then
  source $ZSH/oh-my-zsh.sh
fi

if [ -d $HOME/.zplug ] && [ -f $HOME/.zplug/init.zsh ]; then
  source $HOME/.zplug/init.zsh

  # NOTE: ZShell Plugins
  zplug "b4b4r07/enhancd", use:init.sh
  zplug "k4rthik/git-cal", as:command
  zplug "plugins/git",   from:oh-my-zsh
  zplug "zsh-users/zsh-autosuggestions"
  zplug "zsh-users/zsh-completions"
  zplug "zsh-users/zsh-history-substring-search"
  zplug "zsh-users/zsh-syntax-highlighting", defer:2
  zplug 'geometry-zsh/geometry', as:theme

  # Install plugins if there are plugins that have not been installed
  if ! zplug check --verbose; then
    echo; zplug install
  fi
  # Then, source plugins and add commands to $PATH
  zplug load
fi

plugins=(git)

# [[ $- != *i* ]] && return
# if [[ -z "$TMUX" ]] ;then
#   ID="`tmux ls | grep -vm1 attached | cut -d: -f1`" # get the id of a deattached session
#   if [[ -z "$ID" ]] ;then # if not available create a new one
#     tmux new-session
#   else
#     tmux attach-session -t "$ID" # if available attach to it
#   fi
# fi

source "$HOME/.alias"

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=248'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
