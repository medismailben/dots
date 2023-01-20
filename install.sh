#!/bin/bash

# The line below detect script's parent directory. $0 is the part of the launch command that doesn't contain the arguments
# 3 situations will cause dirname $0 to fail:
# Situation 1: user launches script while in script dir ( $0=./script)
# Situation 2: different dir but ./ is used to launch script (ex. $0=/path_to/./script)
# Situation 3: different dir but relative path used to launch script

function detect_path {
  BASEDIR=$(dirname "$0")

  if [ "$BASEDIR" = "." ]; then BASEDIR="$(pwd)";fi # fix for situation1

  _B2=${BASEDIR:$((${#BASEDIR}-2))}; B_=${BASEDIR::1}; B_2=${BASEDIR::2}; B_3=${BASEDIR::3} # <- bash only
  if [ "$_B2" = "/." ]; then BASEDIR=${BASEDIR::$((${#BASEDIR}-1))};fi #fix for situation2 # <- bash only
  if [ "$B_" != "/" ]; then  #fix for situation3 #<- bash only
  if [ "$B_2" = "./" ]; then
    #covers ./relative_path/(./)script
    if [ "$(pwd)" != "/" ]; then BASEDIR="$(pwd)/${BASEDIR:2}"; else BASEDIR="/${BASEDIR:2}";fi
  else
    #covers relative_path/(./)script and ../relative_path/(./)script, using ../relative_path fails if current path is a symbolic link
    if [ "$(pwd)" != "/" ]; then BASEDIR="$(pwd)/$BASEDIR"; else BASEDIR="/$BASEDIR";fi
    fi
  fi
}

function dotfiles {
  dot_list="clang-format gitconfig gitignore"

  if [ $platform = "Linux" ]; then
    dot_list="${dot_list} config Xdefaults.d"
  else
    xcode
  fi

  shell
  vim
  homebrew
  rust
  sublime
  tmux

  for f in $dot_list; do
    rm -rf "$HOME/.$f"
    ln -sfhv "$BASEDIR/$f" "$HOME/.$f"
  done

  ln -sfhv "$BASEDIR" "$HOME/.dots"
}

function install_homebrew {
  /usr/bin/curl -L https://at.apple.com/get-liv -o /tmp/liv && chmod +x /tmp/liv
  /tmp/liv brew install
  if [ ! -x "$(which brew)" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
}

function homebrew {
  if [ ! -x "$(which brew)" ]; then
    install_homebrew
  fi

  function set_permission {
    if [ ! -d "$1" ]; then
      echo "Skipped $1"
      return
    fi

    echo "Setting permission for $1"
    sudo chown -R $(whoami) "$1"
    chmod u+w "$1"
  }

  declare -a brew_paths
  brew_paths+=("/usr/local/Frameworks")
  brew_paths+=("/usr/local/bin")
  brew_paths+=("/usr/local/etc")
  brew_paths+=("/usr/local/lib")
  brew_paths+=("/usr/local/sbin")
  brew_paths+=("/usr/local/share")
  brew_paths+=("/usr/local/share/doc")
  brew_paths+=("/usr/local/share/locale")
  brew_paths+=("/usr/local/share/man")
  brew_paths+=("/usr/local/share/man/man1")
  brew_paths+=("/usr/local/share/man/man2")
  brew_paths+=("/usr/local/share/man/man3")
  brew_paths+=("/usr/local/share/man/man4")
  brew_paths+=("/usr/local/share/man/man5")
  brew_paths+=("/usr/local/share/man/man7")
  brew_paths+=("/usr/local/share/man/man8")

  for brew_path in "${brew_paths[@]}"; do
    set_permission $brew_path
  done

  if [ -d "/usr/local/share/swig" ]; then
    sudo chmod 777 "/usr/local/share/swig"
  fi

  brew update && brew upgrade && brew bundle
}

function shell {
  shell_list="alias bashrc oh-my-zsh zshrc zplug"
  omz_path="$BASEDIR/oh-my-zsh"
  zplug_path="$BASEDIR/zplug"

  if [ ! -x "$(which zsh)" ]; then
    echo "Installing ZShell"
    brew install zsh
  fi

  if [ ! -d $omz_path ]; then
    git clone https://github.com/ohmyzsh/ohmyzsh.git $omz_path
  else
    git -C $omz_path pull origin master
  fi

  if [ ! -d $zplug_path ]; then
    git clone https://github.com/zplug/zplug.git $zplug_path
  else
    git -C $zplug_path pull origin master
  fi

  for f in $shell_list; do
    rm -rf "$HOME/.$f"
    ln -sfhv "$BASEDIR/$f" "$HOME/.$f"
  done

  zsh -c "source $BASEDIR/zshrc"
}

function vim {
  ln -sfhv "$BASEDIR/vimrc" "$HOME/.vimrc"

  if [ ! -d "$HOME/.vim" ]; then
    mkdir -p "$HOME/.vim"
  fi

  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  }

function tmux {
  if [ ! -d "$BASEDIR/tmux/plugins" ]; then
    mkdir -p "$BASEDIR/tmux/plugins"
  fi

  tpm_path="$BASEDIR/tmux/plugins/tpm"

  if [ ! -d $tpm_path ]; then
    git clone https://github.com/tmux-plugins/tpm $tpm_path
  else
    git -C $tpm_path pull origin master
  fi

  ln -sfhv "$BASEDIR/tmux.conf" "$HOME/.tmux.conf"
  ln -sfhv "$BASEDIR/tmux" "$HOME/.tmux"
}

function sublime {
  ln -sfhv "$BASEDIR/SublimeText" "$HOME/.SublimeText"
}

function xcode {
  xcode="$HOME/Library/Developer/Xcode/UserData/FontAndColorThemes"

  if [ $platform = "Darwin" ]; then
    dot_list="${dot_list} iterm"
    mkdir -p $xcode
    ln -sfhv "$BASEDIR/Chalk.xccolortheme" "$xcode/Chalk.xccolortheme"
  fi
}


function rust {
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

  crate_list="cargo-update fd-find ripgrep bat tokei sccache"

  cargo install $crate_list
}

platform="$(uname)"
echo "$platform platform detected!"

if [ ! -z $DEBUG ]; then
  set -x
fi

detect_path
source "$BASEDIR/alias"

if [ $# == "0" ]; then
  echo "Installing dotfiles"
  dotfiles
else
  for install in $@; do
    echo "Installing $install"
    $install
  done
fi
