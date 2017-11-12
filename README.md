homebrew-kde
============

[![Build Status](https://travis-ci.org/KDE-mac/homebrew-kde.svg?branch=master)](https://travis-ci.org/KDE-mac/homebrew-kde)

Experimental Homebrew (http://brew.sh) tap for KDE Frameworks on Mac OS X.

To add the KDE Frameworks Tap to your homebrew installation:

```sh
brew tap kde-mac/kde
```

In order to build them, you first need an up to date Qt:

```sh
brew install dbus
brew install qt
```

**Note**: It seems that building Qt currently requires the whole Xcode to be installed

**Note**: Read the D-Bus notes below if this is your first D-Bus installation.

**Note**: Webkit for Qt is installed by separate package called `qt-webkit` if you want use kdevelop or kdewebkit

Now, the fun begins. You can either install individual frameworks via

```sh
brew install kde-mac/kde/kf5-karchive
```

or you can install them all with the install.sh shell script provided in the
*tools* directory:

```sh
cd `brew --prefix`/Homebrew/Library/Taps/kde-mac/homebrew-kde
./tools/install.sh
```

Note that *install.sh* passes all parameters on to brew, so you can specify
any brew parameter like *--verbose* also to *install.sh*

**Uninstallation**

To remove all KDE Frameworks 5 packages, run:

```sh
brew uninstall `brew list -1 | grep '^kf5-'`
rm -rf /Applications/KDE
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
`brew --prefix`/Homebrew/Library/Taps/KDE-mac/homebrew-kde/tools/install.sh --HEAD
```

**D-Bus first time users**

Follow the description in the D-Bus formula to set up the LaunchAgent. You might
have to log out and log in again in order to make it work.

To verify D-Bus working with Qt:

```sh
echo $DBUS_LAUNCHD_SESSION_BUS_SOCKET
`brew --prefix qt`/bin/qdbus
```

The first command should echo a valid path, e.g. */tmp/launch-NHyucl/unix_domain_listener*.
The second command should show the available services, at least *org.freedesktop.DBus*.
