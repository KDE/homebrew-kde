#!/usr/bin/env bash

brew update
export HOMEBREW_NO_AUTO_UPDATE=1

brew uninstall -f --ignore-dependencies `brew ls --formula --full-name | grep '^kde-mac/kde'`
rm -rf ~/Applications/KDE
