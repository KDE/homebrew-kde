# Homebrew KDE

Experimental [Homebrew](http://brew.sh) tap for KDE Frameworks and Applications on macOS.

To add the this tap to your Homebrew installation:

```sh
brew untap kde-mac/kde 2> /dev/null
brew tap kde-mac/kde https://invent.kde.org/packaging/homebrew-kde.git --force-auto-update
"$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
```

## Migration

Currently this tap is in process of migration most of frameworks to homebrew/core, so it's best practice to run `"$(brew --repo kde-mac/kde)/tools/do-caveats.sh"` in case you are seeing any issue with linking. Sorry for inconvenience.

## Installation 

Now, the fun begins. You can either install individual frameworks via

```sh
brew install kde-mac/kde/kf5-attica
```

or you can install them all with the install.sh shell script provided in the `tools` directory:

```sh
"$(brew --repo kde-mac/kde)/tools/install.sh"
```

Note that `install.sh` passes all parameters on to brew, so you can specify any brew parameter like `--verbose` also to `install.sh`

## Uninstallation

To remove all KDE Frameworks 5 packages, run:

```sh
"$(brew --repo kde-mac/kde)/tools/uninstall.sh"
```

## Installing HEAD

Currently, installing a formula installs the last released version from tarballs. However, not all frameworks and apps were released as tarballs yet or latest stable release fails to build. If you get an error saying *is a head-only formula*, that formula can only be installed from latest git and not from released packages. This can be done by passing `--HEAD` as parameter to brew.

Note that installing from latest git usually also means that all dependend packages are expected to come from latest git, so to prevent potential errors, you should uninstall all installed kf5 formulas (see chapter [Uninstallation](#Uninstallation) above) and install everything from git, for example by using the `install.sh` utility:

```sh
"$(brew --repo kde-mac/kde)/tools/install.sh" --HEAD
```