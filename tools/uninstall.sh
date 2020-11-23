#!/usr/bin/env bash

brew uninstall -f --ignore-dependencies `brew ls --formula --full-name | grep '^kde-mac/kde'`
rm -rf ~/Applications/KDE
