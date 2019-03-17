class Ktorrent < Formula
  desc "Powerful BitTorrent client for KDE"
  homepage "https://kde.org/applications/internet/ktorrent/"
  url "https://download.kde.org/stable/ktorrent/5.1.1/src/ktorrent-5.1.1.tar.xz"
  sha256 "b54149cf1dd3ed59cb7be54c326469a64e152f39f2d7db01de9fdd6b2ce3562a"

  head "git://anongit.kde.org/ktorrent.git"
  depends_on "boost" => :build
  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "KDE-mac/kde/kf5-breeze-icons"
  depends_on "KDE-mac/kde/kf5-kcmutils"
  depends_on "KDE-mac/kde/kf5-kio"
  depends_on "KDE-mac/kde/kf5-knotifyconfig"
  depends_on "KDE-mac/kde/kf5-kross"
  depends_on "KDE-mac/kde/libktorrent"

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
      "#{bin}/ktorrent.app/Contents/Info.plist"
    system "/usr/libexec/PlistBuddy",
      "-c", "Add :LSEnvironment:QT_PLUGIN_PATH string \"#{qtpp}\:#{HOMEBREW_PREFIX}/lib/qt5/plugins\"",
      "#{bin}/ktupnptest.app/Contents/Info.plist"
  end

  def post_install
    mkdir_p HOMEBREW_PREFIX/"share/ktorrent"
    ln_sf HOMEBREW_PREFIX/"share/icons/breeze/breeze-icons.rcc", HOMEBREW_PREFIX/"share/ktorrent/icontheme.rcc"
  end

  def caveats; <<~EOS
    You need to take some manual steps in order to make this formula work:
      ln -sfv "$(brew --prefix)/share/ktorrent" "$HOME/Library/Application Support"
      ln -sfv "$(brew --prefix)/share/kxmlgui5" "$HOME/Library/Application Support"
      ln -sfv "$(brew --prefix)/share/knotifications5" "$HOME/Library/Application Support"
      mkdir -pv "$HOME/Applications/KDE"
      ln -sfv "$(brew --prefix)/opt/ktorrent/bin/ktorrent.app" "$HOME/Applications/KDE/"
      ln -sfv "$(brew --prefix)/opt/ktorrent/bin/ktupnptest.app" "$HOME/Applications/KDE/"
  EOS
  end

  test do
    assert `"#{bin}/ktorrent.app/Contents/MacOS/ktorrent" --help | grep -- --help` =~ /--help/
    assert `"#{bin}/ktupnptest.app/Contents/MacOS/ktupnptest" --help | grep -- --help` =~ /--help/
  end
end
