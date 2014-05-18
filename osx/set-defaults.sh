defaults write -g ApplePressAndHoldEnabled -bool false
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1
defaults write NSGlobalDomain KeyRepeat -int 0
chflags nohidden ~/Library

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
