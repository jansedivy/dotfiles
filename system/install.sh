#!/bin/sh

info() {
  printf "  [ \033[00;34m..\033[0m ] $1"
}

user() {
  printf "\r  [ \033[0;33m?\033[0m ] $1 "
}

success() {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail() {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

install_package() {
  name=$1
  shift
  info "$name"
  command=$@
  $command > /dev/null 2>&1
  out=$?
  if [ $out -eq 0 ];then
    success "$name"
  else
    fail "Error doing: \"$command\""
  fi
}

  printf "[ \033[00;33mSystem Apps\033[0m ]\n"
install_package "Homebrew Update" brew update
install_package "Homebrew Upgrade" brew upgrade

install_package "Installing Zsh" brew install zsh
install_package "Installing Node" brew install node
install_package "Installing Hub" brew install hub
install_package "Installing Tmux" brew install tmux
install_package "Installing Coreutils" brew install coreutils
install_package "Installing Tmux stuff" brew install reattach-to-user-namespace
install_package "Installing Ack" brew install ack
install_package "Installing Ag" brew install the_silver_searcher
install_package "Installing jq" brew install jq
install_package "Installing Python 3" brew install python3
install_package "Installing gnu sed" brew install gnu-sed
install_package "Installing diff-so-fancy" brew install diff-so-fancy
install_package "Installing fzf" brew install fzf && /usr/local/opt/fzf/install

install_package "Installing speed-test" npm install speed-test -g
install_package "Installing vmd" npm install vmd -g
install_package "Installing ESLint" npm install eslint -g
install_package "Installing ESLint React" npm install eslint-plugin-react -g
install_package "Installing ESLint babel" npm install babel-eslint -g
install_package "Installing flow" npm install flow-bin -g

install_package "Installing Vim" brew install vim --with-python3
install_package "Installing Neovim" brew install neovim/neovim/neovim --override-system-vim --with-python3

install_package "Homebrew Cask" brew install caskroom/cask/brew-cask
install_package "Homebrew tap versions" brew tap caskroom/versions

install_package "Installing app Chrome canary" brew cask install google-chrome-canary 2> /dev/null

install_package "Installing app Firefox" brew cask install firefox 2> /dev/null
install_package "Installing app Firefox nightly" brew cask install firefox-nightly 2> /dev/null

install_package "Installing app Spotify" brew cask install spotify 2> /dev/null
install_package "Installing app iTerm2" brew cask install iterm2 2> /dev/null
install_package "Installing app Transmission" brew cask install transmission 2> /dev/null
install_package "Installing app ImageOptim" brew cask install imageoptim 2> /dev/null
install_package "Installing app OpenEmu" brew cask install openemu 2> /dev/null
install_package "Installing app AppCleaner" brew cask install appcleaner 2> /dev/null
install_package "Installing app Atom" brew cask install atom 2> /dev/null
install_package "Installing app Hex Fiend" brew cask install hex-fiend 2> /dev/null
install_package "Installing app TeamViewer" brew cask install teamviewer 2> /dev/null
install_package "Installing app coconutBattery" brew cask install coconutbattery 2> /dev/null
install_package "Installing app Dropbox" brew cask install dropbox 2> /dev/null
install_package "Installing app gfxCardStatus" brew cask install gfxcardstatus 2> /dev/null
install_package "Installing app Steam" brew cask install steam 2> /dev/null
install_package "Installing app Skype" brew cask install skype 2> /dev/null
install_package "Installing app smcFanControl" brew cask install smcfancontrol 2> /dev/null
install_package "Installing app MacDown" brew cask install macdown 2> /dev/null
install_package "Installing app TeamSpeak" brew cask install teamspeak-client 2> /dev/null
install_package "Installing app Calibre" brew cask install calibre 2> /dev/null
install_package "Installing app Numi" brew cask install numi 2> /dev/null
install_package "Installing app Cloak" brew cask install cloak 2> /dev/null

install_package "Homebrew tap fonts" brew tap caskroom/fonts

install_package "Installing font Hack" brew cask install font-hack

install_package "Cleanup" brew cleanup

exit 0
