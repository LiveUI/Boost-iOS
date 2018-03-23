#!/bin/bash

# Brew
echo "Updating Brew"
brew update --verbose
brew upgrade --verbose

# Update git & submodules
echo "Updating main repo"
git pull

#echo "Updating Submodules"
#git submodule sync
#git submodule update --init --recursive --recommend-shallow

# Cocoapods
pod update

# Carthage
brew install carthage

# Update Carthage
echo "Updating Carthage"
carthage update --cache-builds --use-ssh

