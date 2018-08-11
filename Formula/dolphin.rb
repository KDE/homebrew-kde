class Dolphin < Formula
  desc "KDE File Manager"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/applications/18.04.3/src/dolphin-18.04.3.tar.xz"
  sha256 "41fd637f6283c984774a4cd143960be8c7318a13d5ea75f86d1d5695ed4ca3c6"

  head "git://anongit.kde.org/dolphin.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build

  depends_on "ruby" => :optional
  depends_on "KDE-mac/kde/konsole" => :optional

  depends_on "KDE-mac/kde/kf5-breeze-icons"
  depends_on "KDE-mac/kde/kf5-kcmutils"
  depends_on "KDE-mac/kde/kf5-kdelibs4support"
  depends_on "KDE-mac/kde/kf5-kfilemetadata"
  depends_on "KDE-mac/kde/kf5-kinit"
  depends_on "KDE-mac/kde/kf5-knewstuff"
  depends_on "KDE-mac/kde/kf5-kparts"
  depends_on "KDE-mac/kde/kio-extras"

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
      "$(brew --cellar)/dolphin/18.04.3/bin/dolphin.app/Contents/Info.plist"
  end

  def post_install
    mkdir_p HOMEBREW_PREFIX/"share/dolphin"
    ln_sf HOMEBREW_PREFIX/"share/icons/breeze/breeze-icons.rcc", HOMEBREW_PREFIX/"share/dolphin/icontheme.rcc"
  end

  def caveats; <<~EOS
    You need to take some manual steps in order to make this formula work:
      ln -sfv "$(brew --prefix)/share/dolphin" "$HOME/Library/Application Support"
      ln -sfv "$(brew --prefix)/share/config.kcfg" "$HOME/Library/Application Support"
      ln -sfv "$(brew --prefix)/share/kservices5" "$HOME/Library/Application Support"
      ln -sfv "$(brew --prefix)/share/kservicetypes5" "$HOME/Library/Application Support"
      mkdir -pv "$HOME/Applications/KDE"
      ln -sfv "$(brew --cellar)/dolphin/18.04.3/bin/dolphin.app" "$HOME/Applications/KDE/"
  EOS
  end
end
