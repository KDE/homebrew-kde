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

Note: Read the D-Bus notes below if this is your first D-Bus installation.

Now, the fun begins. Please note that all the kf5 formulas are HEAD only.
This means that they come directly from git and might break at any moment.

To use them, you need to specify --HEAD with every kf5 formula you install,
including the dependencies. A sample command that installs a whole bunch
of kf5 libraries:

```sh
cd `brew --prefix`/Library/Taps/haraldf-kf5
`echo -n "brew install --verbose " && find . -name "kf5-*.rb" -not -name "kf5-kdoctools.rb" -exec echo -n "--HEAD {} " \; && echo`
```

After that, your favorite KDE application should hopefully build :)

**Uninstalltion**

To remove all KDE Frameworks 5 packages, run:

```sh
brew uninstall `brew list -1 | grep '^kf5-'`
```

**Known Issues**

KDocTools don't build.

**D-Bus first time users**

Follow the description in the D-Bus formula to set up the LaunchAgent. You might
have to log out and log in again in order to make it work.

To verify D-Bus working with Qt:

```sh
echo $DBUS_LAUNCHD_SESSION_BUS_SOCKET
`brew --prefix`/Cellar/qt5/5.2.1/bin/qdbus
```

The first command should echo a valid path, e.g. */tmp/launch-NHyucl/unix_domain_listener*.
The second command should show the available services, at least *org.freedesktop.DBus*.
