require "formula"

class Dolphin < Formula
  url "https://download.kde.org/stable/applications/17.08.3/src/dolphin-17.08.3.tar.xz"
  sha256 "651565291d06faa60fc4baf3b11aa4ba766da8b654b1c8891ec0cb1088316b09"
  revision 2
  desc "KDE File Manager"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/dolphin.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build

  depends_on "ruby" => :optional
  depends_on "KDE-mac/kde/konsole" => :optional

  depends_on "qt"
  depends_on "KDE-mac/kde/kf5-knewstuff"
  depends_on "KDE-mac/kde/kf5-kcmutils"
  depends_on "KDE-mac/kde/kf5-kparts"
  depends_on "KDE-mac/kde/kf5-kinit"
  depends_on "KDE-mac/kde/kf5-kcoreaddons"
  depends_on "KDE-mac/kde/kio-extras"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"
    args << "-DCMAKE_INSTALL_BUNDLEDIR=#{prefix}/bin"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
    system "/usr/libexec/PlistBuddy",
      "-c", "Add :LSEnvironment:QT_PLUGIN_PATH string \"#{HOMEBREW_PREFIX}/lib/qt5/plugins\"",
      "#{bin}/dolphin.app/Contents/Info.plist"
  end

  def post_install
    mkdir_p HOMEBREW_PREFIX/"share/dolphin"
    ln_sf HOMEBREW_PREFIX/"share/icons/breeze/breeze-icons.rcc", HOMEBREW_PREFIX/"share/dolphin/icontheme.rcc"
  end

  def caveats; <<-EOS.undent
    You need to take some manual steps in order to make this formula work:
      ln -sf "$(brew --prefix)/share/dolphin" ~/Library/"Application Support"
      ln -sf "$(brew --prefix)/share/config.kcfg" ~/Library/"Application Support"
      mkdir -p ~/Applications/KDE
      ln -sf "#{prefix}/bin/dolphin.app" ~/Applications/KDE/
    EOS
  end
end
