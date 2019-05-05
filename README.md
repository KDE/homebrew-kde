homebrew-kde
============

[![Build Status](https://travis-ci.org/KDE-mac/homebrew-kde.svg?branch=master)](https://travis-ci.org/KDE-mac/homebrew-kde)  [![Gitter chat](https://badges.gitter.im/KDE-mac/Lobby.png)](https://gitter.im/KDE-mac/Lobby "Gitter chat")

Experimental Homebrew (http://brew.sh) tap for KDE Frameworks on macOS.

To add the KDE Frameworks Tap to your homebrew installation:

```sh
brew tap kde-mac/kde
```

In order to build them, you first need to do one manuall step that setup all things in order to work-around brew sandbox limitations

```sh
"$(brew --repo kde-mac/kde)/tools/all-fixes.sh"
```

**Note**: It seems that building Qt currently requires the whole Xcode to be installed

**Note**: Webkit for Qt is installed by separate package called `qt-webkit` if you want use kdevelop or kdewebkit

Now, the fun begins. You can either install individual frameworks via

```sh
brew install kde-mac/kde/kf5-karchive
```

or you can install them all with the install.sh shell script provided in the
*tools* directory:

```sh
"$(brew --repo kde-mac/kde)/tools/install.sh"
```

Note that *install.sh* passes all parameters on to brew, so you can specify
any brew parameter like *--verbose* also to *install.sh*

**Uninstallation**

To remove all KDE Frameworks 5 packages, run:

```sh
"$(brew --repo kde-mac/kde)/tools/uninstall.sh"
```

**Installing HEAD**

Currently, installing a formula installs the last released version from tarballs.
However, not all frameworks and apps were released as tarballs yet. If you get
an error saying *is a head-only formula*, that formula can only be installed from
latest git and not from released packages. This can be done by passing *--HEAD* as
parameter to brew.

Note that installing from latest git usually also means that all dependend packages
are expected to come from latest git, so to prevent potential errors, you should
uninstall all installed kf5 formulas (see chapter *Uninstallation* above) and install
everything from git, for example by using the *install.sh* utility:

```sh
"$(brew --repo kde-mac/kde)/tools/install.sh" --HEAD
```