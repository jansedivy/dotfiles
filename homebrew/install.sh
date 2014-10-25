#!/bin/sh
if test ! $(which brew)
then
  echo "  Installing Homebrew for you."
  ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)" > /tmp/homebrew-install.log
fi

brew update
brew upgrade

brew install zsh
brew install node
brew install hub
brew install tmux
brew install coreutils
brew install reattach-to-user-namespace
brew install the_silver_searcher

brew install vim --override-system-vim

brew install caskroom/cask/brew-cask
brew tap caskroom/versions

brew cask install google-chrome-canary 2> /dev/null

brew cask install firefox 2> /dev/null
brew cask install firefox-nightly 2> /dev/null

brew cask install spotify 2> /dev/null
brew cask install iterm2 2> /dev/null
brew cask install things 2> /dev/null
brew cask install mou 2> /dev/null
brew cask install transmission 2> /dev/null
brew cask install imageoptim 2> /dev/null
brew cask install openemu 2> /dev/null
brew cask install appcleaner 2> /dev/null
brew cask install atom 2> /dev/null
brew cask install hex-fiend 2> /dev/null
brew cask install teamviewer 2> /dev/null
brew cask install coconutbattery 2> /dev/null
brew cask install dropbox 2> /dev/null
brew cask install gfxcardstatus 2> /dev/null
brew cask install steam 2> /dev/null
brew cask install skype 2> /dev/null
brew cask install smcfancontrol 2> /dev/null
brew cask install toggldesktop 2> /dev/null
brew cask install macdown 2> /dev/null
brew cask install colorpicker-skalacolor 2> /dev/null
brew cask install teamspeak-client 2> /dev/null
brew cask install calibre 2> /dev/null
brew cask install mailbox 2> /dev/null
brew cask install launchrocket 2> /dev/null
# cask install parallels 2> /dev/null

brew cleanup

exit 0
