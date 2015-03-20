# Show the ~/Library folder.
chflags nohidden ~/Library

# Don't open applications again after restart
defaults write -g ApplePersistence -bool no
