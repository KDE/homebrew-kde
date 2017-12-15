class Konsole < Formula
  desc "KDE's terminal emulator"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/applications/17.12.0/src/konsole-17.12.0.tar.xz"
  sha256 "adc6e2d36d84f0460db1ee04fa93f5ac5148f5d64acf96de262e712dfdc05f41"
  revision 1

  head "git://anongit.kde.org/konsole.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "kde-mac/kde/kf5-kdoctools" => :build

  depends_on "KDE-mac/kde/kf5-breeze-icons"
  depends_on "KDE-mac/kde/kf5-kinit"
  depends_on "KDE-mac/kde/kf5-knotifyconfig"
  depends_on "KDE-mac/kde/kf5-kparts"
  depends_on "KDE-mac/kde/kf5-kpty"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"
    args << "-DCMAKE_INSTALL_BUNDLEDIR=#{bin}"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
    # Extract Qt plugin path
    qtpp = `#{Formula["qt"].bin}/qtpaths --plugin-dir`.chomp
    system "/usr/libexec/PlistBuddy",
      "-c", "Add :LSEnvironment:QT_PLUGIN_PATH string \"#{qtpp}\:#{HOMEBREW_PREFIX}/lib/qt5/plugins\"",
      "#{bin}/konsole.app/Contents/Info.plist"
  end

  def post_install
    ln_sf HOMEBREW_PREFIX/"share/icons/breeze/breeze-icons.rcc", HOMEBREW_PREFIX/"share/konsole/icontheme.rcc"
  end

  def caveats; <<-EOS.undent
    You need to take some manual steps in order to make this formula work:
      ln -sf "$(brew --prefix)/share/konsole" "$HOME/Library/Application Support"
      ln -sf "$(brew --prefix)/share/knotifications5" "$HOME/Library/Application Support"
      ln -sf "$(brew --prefix)/share/kservices5" "$HOME/Library/Application Support"
      ln -sf "$(brew --prefix)/share/kservicetypes5" "$HOME/Library/Application Support"
      ln -sf "$(brew --prefix)/share/metainfo" "$HOME/Library/Application Support"
      mkdir -p $HOME/Applications/KDE
      ln -sf "#{prefix}/bin/konsole.app" $HOME/Applications/KDE/
    EOS
  end
end
