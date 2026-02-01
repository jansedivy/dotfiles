#!/bin/sh

brew update

brew install font-hack-nerd-font

brew install git diff-so-fancy

brew install fzf neovim zoxide tmux zsh coreutils reattach-to-user-namespace rg luarocks wget imagemagick

brew install nodenv
brew install go
brew install llvm ctags cmake clang-build-analyzer emscripten

brew install git-absorb

brew install --cask spotify ghostty telegram discord microsoft-edge 1password numi imhex the-unarchiver monitorcontrol imaging-edge-webcam visual-studio-code cursor kap

brew install --cask git-credential-manager

defaults write com.apple.dock "tilesize" -int "46" && killall Dock
defaults write NSGlobalDomain "ApplePressAndHoldEnabled" -bool "false"
defaults write com.apple.HIToolbox AppleFnUsageType -int "0"
defaults write kCFPreferencesAnyApplication TSMLanguageIndicatorEnabled -bool "false"
defaults write -g InitialKeyRepeat -int 10
defaults write -g KeyRepeat -int 1
