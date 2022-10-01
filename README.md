# Homebrew KDE
Experimental [Homebrew](http://brew.sh) tap for KDE Frameworks and Applications on macOS.

To add the this tap to your Homebrew installation:
```sh
brew untap kde-mac/kde 2> /dev/null
brew tap kde-mac/kde https://invent.kde.org/packaging/homebrew-kde.git --force-auto-update
"$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
```

## Migration
Currently this tap is in process of migration most of frameworks to `homebrew/core`, so it's best practice to run `"$(brew --repo kde-mac/kde)/tools/do-caveats.sh"` in case you are seeing any issue with linking. Sorry for inconvenience.

## Installation 
Now, the fun begins. You can either install individual frameworks via
```sh
brew install kde-mac/kde/kf5-attica
```
or you can install them all with a provided Brewfile provided in the repo's root directory:
```sh
brew bundle --verbose --file "$(brew --repo kde-mac/kde)/Brewfile"
```

## Casks 
Some apps are offered in binary form via casks, so if you want to install binary package instead of formula please add `--cask` flag, e.g:
```sh
brew install --cask kde-mac/kde/kdeconnect
```

## Upgrading Casks
Some of casks are set to track latest stable nightly build from KDE's Binary Factory, so you may upgrade them via:
```sh
brew upgrade --greedy-latest
```

## Uninstallation
To remove all KDE formulae, run:
```sh
"$(brew --repo kde-mac/kde)/tools/uninstall.sh"
```

## Installing HEAD
Currently, installing a formula installs the last released version from tarballs. However, not all frameworks and apps were released as tarballs yet or latest stable release fails to build. If you get an error saying *is a head-only formula*, that formula can only be installed from latest git and not from released packages. This can be done by passing `--HEAD` as parameter to brew.

## GUI KDE apps aren't available in Spotlight
This is a limitation of Spotlight, it just doesn’t want search in some folders, even a symlink to /Applications doesn’t help. But as workaround you may launch KDE apps from Launchpad. Aforementioned `tools/do-caveats.sh` script creates symlinks to GUI apps in `~/Applications/KDE`, making them available to be picked manually and searchable inside Launchpad. But its search is not as convenient and fast as via Spotlight.
