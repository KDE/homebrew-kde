class Kmymoney < Formula
  desc "Personal finance manager for KDE which operates similarly to MS-Money or Quicken"
  homepage "https://kmymoney.org"
  # url "https://download.kde.org/stable/kmymoney/4.8.1/src/kmymoney-4.8.1.7z"
  # sha256 "4435acabb3c9771dd39471651767c857087b5fe4f5cd43132c19cdc92aa6cbab"
  revision 1

  head "git://anongit.kde.org/kmymoney.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "docbook-xsl" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "KDE-mac/kde/kf5-kross" => :optional

  depends_on "gpgme"
  depends_on "boost"
  depends_on "libical"
  depends_on "libofx"
  depends_on "KDE-mac/kde/kf5-breeze.icons"
  depends_on "KDE-mac/kde/kf5-kcmutils"
  depends_on "KDE-mac/kde/kf5-kio"
  depends_on "KDE-mac/kde/libalkimia"
  depends_on "KDE-mac/kde/kdiagram"

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
      "#{bin}/kmymoney.app/Contents/Info.plist"
  end

  def post_install
    system HOMEBREW_PREFIX/"bin/update-mime-database", HOMEBREW_PREFIX/"share/mime"
    ln_sf HOMEBREW_PREFIX/"share/icons/breeze/breeze-icons.rcc", HOMEBREW_PREFIX/"share/kmymoney/icontheme.rcc"
  end

  def caveats; <<-EOS.undent
    You need to take some manual steps in order to make this formula work:
      ln -sf "$(brew --prefix)/share/kmymoney" "$HOME/Library/Application Support"
      ln -sf "$(brew --prefix)/share/kmm_weboob" "$HOME/Library/Application Support"
      ln -sf "$(brew --prefix)/share/kmm_printcheck" "$HOME/Library/Application Support"
      ln -sf "$(brew --prefix)/share/config.kcfg" "$HOME/Library/Application Support"
      ln -sf "$(brew --prefix)/share/kservices" "$HOME/Library/Application Support"
      ln -sf "$(brew --prefix)/share/kservicetypes5" "$HOME/Library/Application Support"
      ln -sf "$(brew --prefix)/share/kconf_update" "$HOME/Library/Application Support"
      ln -sf "$(brew --prefix)/share/metainfo" "$HOME/Library/Application Support"
      mkdir -p $HOME/Applications/KDE
      ln -sf "#{prefix}/bin/kmymoney.app" $HOME/Applications/KDE/
    EOS
  end
end
