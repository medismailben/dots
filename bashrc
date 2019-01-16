[[ $- != *i* ]] && return

PS1="\w\n──── \[$(tput sgr0)\]"

source "$HOME/.alias"
