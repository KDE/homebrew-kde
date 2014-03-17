homebrew-kf5
============

Experimental Homebrew (http://brew.sh) tap for KDE Frameworks on Mac OS X.

To add the KDE Frameworks Tap to your homebrew installation:

```sh
brew tap haraldf/kf5
```

In order to build them, you first need an up to date Qt 5 with
D-Bus support:

```sh
brew install d-bus
brew install qt5 --with-d-bus
```

Note: It seems that building Qt currently requires the whole Xcode to be installed
Note: Read the D-Bus notes below if this is your first D-Bus installation.

Now, the fun begins. You can either install individual frameworks via

```sh
brew install haraldf/kf5/kf5-karchive
```

or you can install them all with the install.sh shell script provided in the
*tools* directory.

**Uninstallation**

To remove all KDE Frameworks 5 packages, run:

```sh
brew uninstall `brew list -1 | grep '^kf5-'`
rm -rf /Applications/KDE5
```

**D-Bus first time users**

Follow the description in the D-Bus formula to set up the LaunchAgent. You might
have to log out and log in again in order to make it work.

To verify D-Bus working with Qt:

```sh
echo $DBUS_LAUNCHD_SESSION_BUS_SOCKET
`brew --prefix`/opt/qt5/bin/qdbus
```

The first command should echo a valid path, e.g. */tmp/launch-NHyucl/unix_domain_listener*.
The second command should show the available services, at least *org.freedesktop.DBus*.
