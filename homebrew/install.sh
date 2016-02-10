#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

# Check for Homebrew
if test ! $(which brew)
then
  echo "  Installing Homebrew for you."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install homebrew packages
brew install grc coreutils spark wget irssi

echo "Getting total terminal dmg..."
wget http://downloads.binaryage.com/TotalTerminal-1.4.11.dmg

echo "Getting seqelpro..."
wget https://sequel-pro.googlecode.com/files/sequel-pro-1.0.2.dmg

exit 0
