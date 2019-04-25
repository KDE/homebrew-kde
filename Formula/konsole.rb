class Konsole < Formula
  desc "KDE's terminal emulator"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/applications/19.04.0/src/konsole-19.04.0.tar.xz"
  sha256 "62d53840f6cac4686feafa7f75d641bb56867b7dfc12e6ce95afa7e796e37cef"

  head "git://anongit.kde.org/konsole.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "kde-mac/kde/kf5-kdoctools" => :build
  depends_on "ninja" => :build
  depends_on "KDE-mac/kde/kf5-breeze-icons"
  depends_on "KDE-mac/kde/kf5-kinit"
  depends_on "KDE-mac/kde/kf5-knewstuff"
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
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
    # Extract Qt plugin path
    qtpp = `#{Formula["qt"].bin}/qtpaths --plugin-dir`.chomp
    system "/usr/libexec/PlistBuddy",
      "-c", "Add :LSEnvironment:QT_PLUGIN_PATH string \"#{qtpp}\:#{HOMEBREW_PREFIX}/lib/qt5/plugins\"",
      "#{bin}/konsole.app/Contents/Info.plist"
  end

  def post_install
    mkdir_p HOMEBREW_PREFIX/"share/konsole"
    ln_sf HOMEBREW_PREFIX/"share/icons/breeze/breeze-icons.rcc", HOMEBREW_PREFIX/"share/konsole/icontheme.rcc"
  end

  def caveats; <<~EOS
    You need to take some manual steps in order to make this formula work:
      ln -sfv "$(brew --prefix)/share/konsole" "$HOME/Library/Application Support"
      ln -sfv "$(brew --prefix)/share/knotifications5" "$HOME/Library/Application Support"
      ln -sfv "$(brew --prefix)/share/kservices5" "$HOME/Library/Application Support"
      ln -sfv "$(brew --prefix)/share/kservicetypes5" "$HOME/Library/Application Support"
      ln -sfv "$(brew --prefix)/share/metainfo" "$HOME/Library/Application Support"
      mkdir -pv "$HOME/Applications/KDE"
      ln -sfv "$(brew --prefix)/opt/konsole/bin/konsole.app" "$HOME/Applications/KDE/"
  EOS
  end

  test do
    assert `"#{bin}/konsole.app/Contents/MacOS/konsole" --help | grep -- --help` =~ /--help/
  end
end
