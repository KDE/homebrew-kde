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
brew install haraldf/kf5/qt5 --with-d-bus
```

Note: Read the D-Bus notes below if this is your first D-Bus installation.

Now, the fun begins. Please note that all the kf5 formulas are HEAD only.
This means that they come directly from git and might break at any moment.

To use them, you need to specify --HEAD with every kf5 formula you install,
including the dependencies. A sample command that installs a whole bunch
of kf5 libraries:

```sh
brew install --verbose \
 --HEAD kf5-attica.rb \
 --HEAD kf5-extra-cmake-modules.rb \
 --HEAD kf5-karchive.rb \
 --HEAD kf5-kauth.rb \
 --HEAD kf5-kbookmarks.rb \
 --HEAD kf5-kcodecs.rb \
 --HEAD kf5-kcompletion.rb \
 --HEAD kf5-kconfig.rb \
 --HEAD kf5-kconfigwidgets.rb \
 --HEAD kf5-kcoreaddons.rb \
 --HEAD kf5-kcrash.rb \
 --HEAD kf5-kdbusaddons.rb \
 --HEAD kf5-kglobalaccel.rb \
 --HEAD kf5-kguiaddons.rb \
 --HEAD kf5-ki18n.rb \
 --HEAD kf5-kiconthemes.rb \
 --HEAD kf5-kio.rb \
 --HEAD kf5-kitemviews.rb \
 --HEAD kf5-kjobwidgets.rb \
 --HEAD kf5-kjs.rb \
 --HEAD kf5-knotifications.rb \
 --HEAD kf5-kparts.rb \
 --HEAD kf5-kprintutils.rb \
 --HEAD kf5-kservice.rb \
 --HEAD kf5-ktexteditor.rb \
 --HEAD kf5-ktextwidgets.rb \
 --HEAD kf5-kwidgetsaddons.rb \
 --HEAD kf5-kwindowsystem.rb \
 --HEAD kf5-kxmlgui.rb \
 --HEAD kf5-solid.rb \
 --HEAD kf5-sonnet.rb \
 --HEAD kf5-umbrella.rb
```

After that, your favorite KDE application should hopefully build :)


**Known Issues**

Headers for some frameworks are pointing to wrong directory, see discussion at
https://git.reviewboard.kde.org/r/115541/

**D-Bus first time users**

Follow the description in the D-Bus formula to set up the LaunchAgent. You might
have to log out and log in again in order to make it work.

To verify D-Bus working with Qt:

```sh
echo $DBUS_LAUNCHD_SESSION_BUS_SOCKET
`brew --prefix`/Cellar/qt5/5.2.1/bin/qdbus
```

The first command should echo a valid patch, e.g. */tmp/launch-NHyucl/unix_domain_listener*.
The second command should show the available services, at least *org.freedesktop.DBus*.
