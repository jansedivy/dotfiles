#!/bin/sh

if test ! $(which brew)
then
  echo "  Installing Homebrew for you."
  ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)" > /tmp/homebrew-install.log
fi

brew install hub tmux grc coreutils reattach-to-user-namespace tmux-mem-cpu-load
brew install vim --override-system-vim

exit 0
