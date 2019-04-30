class Okteta < Formula
  desc "KDE hex editor for viewing and editing the raw data of files"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/okteta/0.26.1/src/okteta-0.26.1.tar.xz"
  sha256 "a4c4ee823b225c8bbffed366d9ca73f7951534d4ba1bcb671cd5f743ba1a18af"

  head "git://anongit.kde.org/okteta.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build
  depends_on "ninja" => :build
  depends_on "shared-mime-info" => :build

  depends_on "hicolor-icon-theme"
  depends_on "KDE-mac/kde/kf5-breeze-icons"
  depends_on "KDE-mac/kde/kf5-kcmutils"
  depends_on "KDE-mac/kde/kf5-knewstuff"
  depends_on "KDE-mac/kde/kf5-kparts"
  depends_on "qca"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"
    args << "-DKDE_INSTALL_QTPLUGINDIR=lib/qt5/plugins"
    args << "-DCMAKE_INSTALL_BUNDLEDIR=#{bin}"
    args << "-DUPDATE_MIME_DATABASE_EXECUTABLE=OFF"

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
      "#{bin}/okteta.app/Contents/Info.plist"
  end

  def post_install
    system HOMEBREW_PREFIX/"bin/update-mime-database", HOMEBREW_PREFIX/"share/mime"
    mkdir_p HOMEBREW_PREFIX/"share/okteta"
    ln_sf HOMEBREW_PREFIX/"share/icons/breeze/breeze-icons.rcc", HOMEBREW_PREFIX/"share/okteta/icontheme.rcc"
  end

  def caveats; <<~EOS
    You need to take some manual steps in order to make this formula work:
      ln -sfv "$(brew --prefix)/share/okteta" "$HOME/Library/Application Support"
      ln -sfv "$(brew --prefix)/share/config.kcfg" "$HOME/Library/Application Support"
      ln -sfv "$(brew --prefix)/share/kxmlgui5" "$HOME/Library/Application Support"
      mkdir -pv "$HOME/Applications/KDE"
      ln -sfv "$(brew --prefix)/opt/okteta/bin/okteta.app" "$HOME/Applications/KDE/"
  EOS
  end

  test do
    assert `"#{bin}/okteta.app/Contents/MacOS/okteta" --help | grep -- --help` =~ /--help/
  end
end
