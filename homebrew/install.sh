#!/bin/sh

if test ! $(which brew)
then
  echo "  Installing Homebrew for you."
  ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)" > /tmp/homebrew-install.log
fi

brew tap caskroom/cask
brew tap caskroom/versions

brew install brew-cask
brew install zsh node hub tmux grc coreutils reattach-to-user-namespace the_silver_searcher
brew install vim --override-system-vim

brew cask install google-chrome-canary

brew cask install firefox
brew cask install firefox-nightly

brew cask install spotify
brew cask install iterm2
brew cask install things
brew cask install mou
brew cask install transmission
brew cask install imageoptim
brew cask install openemu
brew cask install appcleaner
brew cask install atom
brew cask install hex-fiend
brew cask install teamviewer
brew cask install coconutbattery
brew cask install dropbox
brew cask install gfxcardstatus
brew cask install steam
brew cask install skype
brew cask install smcfancontrol
brew cask install toggldesktop

exit 0
