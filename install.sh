#!/bin/sh

function dotfiles {
  dot_list="alias bashrc clang-format gitconfig gitignore SublimeText \
    oh-my-zsh vim vimrc tmux.conf tmux zshrc zsh-custom zsh-update"

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

  sudo chown -R $(whoami) /usr/local/Frameworks     \
                          /usr/local/bin            \
                          /usr/local/etc            \
                          /usr/local/lib            \
                          /usr/local/sbin           \
                          /usr/local/share          \
                          /usr/local/share/doc      \
                          /usr/local/share/locale   \
                          /usr/local/share/man      \
                          /usr/local/share/man/man1 \
                          /usr/local/share/man/man2 \
                          /usr/local/share/man/man3 \
                          /usr/local/share/man/man4 \
                          /usr/local/share/man/man5 \
                          /usr/local/share/man/man7 \
                          /usr/local/share/man/man8

  chmod u+w /usr/local/Frameworks     \
            /usr/local/bin            \
            /usr/local/etc            \
            /usr/local/lib            \
            /usr/local/sbin           \
            /usr/local/share          \
            /usr/local/share/doc      \
            /usr/local/share/locale   \
            /usr/local/share/man      \
            /usr/local/share/man/man1 \
            /usr/local/share/man/man2 \
            /usr/local/share/man/man3 \
            /usr/local/share/man/man4 \
            /usr/local/share/man/man5 \
            /usr/local/share/man/man7 \
            /usr/local/share/man/man8

  if [ -d "/usr/local/share/swig" ]; then
    sudo chmod 777 "/usr/local/share/swig"
  fi

  brew_list="tree cmake ninja swig clang-format htop nmap neofetch tmux
  youtube-dl vim ctags-exuberant"
  cask_list="authy discord"

  brew install "$brew_list"

  if [ $platform = "Darwin" ]; then
    brew cask install "$cask_list"
  fi
}

function cargo {
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

  crate_list="fd-find ripgrep bat tokei"

  cargo install $crate_list
}

function arcanist {
  arc_list="libphutil arcanist"
  cellar_path="/usr/local/Cellar"
  bin_path="/usr/local/bin"

  mkdir -p $cellar_path

  for pkg in $arc_list; do
    pkg_path=$cellar_path/$pkg
    if [ ! -d $pkg_path ]; then
      git clone https://github.com/phacility/$pkg.git $pkg_path
    else
      git -C $pkg_path pull origin master
    fi
  done

  ln -svf $cellar_path/arcanist/bin/arc $bin_path/arc
}

platform="$(uname)"
echo "$platform platform detected!"

if [ ! -z $DEBUG ]; then
  set -x
fi

if [ $# == "0" ]; then
  echo "Installing dotfiles"
  dotfiles
else
  for install in $@; do
    echo "Installing $install"
    $install
  done
fi
