class Kmymoney < Formula
  desc "Personal finance manager similar to MS-Money or Quicken"
  homepage "https://kmymoney.org"
  url "https://download.kde.org/stable/kmymoney/5.0.2/src/kmymoney-5.0.2.tar.xz"
  sha256 "57f321ebdb1e8bc04e41531a7d0ce947c65101d7768c2aa45c65370b5d67a593"

  revision 1

  revision 1
  head "git://anongit.kde.org/kmymoney.git"
  depends_on "cmake" => :build
  depends_on "docbook-xsl" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "ninja" => :build
  depends_on "boost"
  depends_on "gpgme"
  depends_on "KDE-mac/kde/kdiagram"
  depends_on "KDE-mac/kde/kf5-breeze-icons"
  depends_on "KDE-mac/kde/kf5-kcmutils"
  depends_on "KDE-mac/kde/kf5-kdewebkit"
  depends_on "KDE-mac/kde/kf5-kio"
  depends_on "KDE-mac/kde/libalkimia"
  depends_on "libical"
  depends_on "libofx"
  depends_on "KDE-mac/kde/kf5-kross" => :optional

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
      "#{bin}/bin/kmymoney.app/Contents/Info.plist"
  end

  def post_install
    system HOMEBREW_PREFIX/"bin/update-mime-database", HOMEBREW_PREFIX/"share/mime"
    ln_sf HOMEBREW_PREFIX/"share/icons/breeze/breeze-icons.rcc", HOMEBREW_PREFIX/"share/kmymoney/icontheme.rcc"
  end

  def caveats; <<~EOS
    You need to take some manual steps in order to make this formula work:
      ln -sfv "$(brew --prefix)/share/kmymoney" "$HOME/Library/Application Support"
      ln -sfv "$(brew --prefix)/share/kmm_weboob" "$HOME/Library/Application Support"
      ln -sfv "$(brew --prefix)/share/kmm_printcheck" "$HOME/Library/Application Support"
      ln -sfv "$(brew --prefix)/share/config.kcfg" "$HOME/Library/Application Support"
      ln -sfv "$(brew --prefix)/share/kservices" "$HOME/Library/Application Support"
      ln -sfv "$(brew --prefix)/share/kservicetypes5" "$HOME/Library/Application Support"
      ln -sfv "$(brew --prefix)/share/kconf_update" "$HOME/Library/Application Support"
      ln -sfv "$(brew --prefix)/share/metainfo" "$HOME/Library/Application Support"
      mkdir -pv "$HOME/Applications/KDE"
      ln -sfv "$(brew --prefix)/opt/kmymoney/bin/kmymoney.app" "$HOME/Applications/KDE/"
  EOS
  end
end
