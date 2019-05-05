#!/usr/bin/env bash

brew uninstall `brew list --full-name -1 | grep '^kde-mac/kde'`
rm -rf ~/Applications/KDE