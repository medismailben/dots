#!/bin/sh

dot_list="alias bashrc clang-format gitconfig gitignore SublimeText \
  oh-my-zsh vim vimrc tmux.conf zshrc zsh-custom zsh-update"

platform=$(uname)

if [ $platform = "Darwin" ]; then
	dot_list="${dot_list} iterm"
elif [ $platform = "Linux"]; then
	dot_list="${dot_list} config Xdefaults.d"
fi

for f in $dot_list; do
  rm -rf "$HOME/.$f"
  ln -sv "$HOME/Documents/dotfiles/$f" "$HOME/.$f"
done
