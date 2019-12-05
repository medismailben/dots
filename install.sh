#!/bin/sh

function dotfiles {
  dot_list="alias bashrc clang-format gitconfig gitignore SublimeText \
    oh-my-zsh vim vimrc tmux.conf zshrc zsh-custom zsh-update"

  xcode="$HOME/Library/Developer/Xcode/UserData/FontAndColorThemes"

  if [ $platform = "Darwin" ]; then
    dot_list="${dot_list} iterm"
    mkdir -p $xcode
    ln -sv Chalk.xccolortheme $xcode
  elif [ $platform = "Linux"]; then
    dot_list="${dot_list} config Xdefaults.d"
  fi

  for f in $dot_list; do
    rm -rf "$HOME/.$f"
    ln -sv "$HOME/Documents/dotfiles/$f" "$HOME/.$f"
  done
}

function apps {
  curl -s http://www.getmacapps.com/raw/821jvawx | sh
  rm -rf "$HOME/getmacapps_temp"
}

function brew {
  # TODO: Add linux brew support
  curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install > install.rb
  # TODO: Add patch to remove macOS Developer Tools install if Xcode is detected
  chmod +x install.rb
  ./install.rb

  if [ -d "/usr/local/share/swig" ]; then
    sudo chmod 777 "/usr/local/share/swig"
  fi

  brew_list="tree cmake ninja swig"
  cask_list="authy discord"

  brew install "$brew_list"

  if [ $platform = "Darwin" ]; then
    brew cask install "$cask_list"
  fi
}

function cargo {
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

  crate_list="fd-find ripgrep bat"

  cargo install $crate_list
}

platform="$(uname)"
echo "$platform platform detected!"

if [ $# == "0" ]; then
  echo "Installing dotfiles"
  dotfiles
else
  for install in $@; do
    echo "Installing $install"
    $install
  done
fi
