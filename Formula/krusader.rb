class Krusader < Formula
  desc "Advanced twin panel (commander style) file manager"
  homepage "https://krusader.org/"
  url "https://download.kde.org/stable/krusader/2.7.1/krusader-2.7.1.tar.xz"
  sha256 "d5c14d7e0698b84a1285efe7058074f760924d13d0823e1b5123fbe771907deb"
  head "https://github.com/yurikoles/krusader.git", :branch => "fix-icons"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-plasma-framework" => :build
  depends_on "ninja" => :build
  depends_on "gettext"
  depends_on "KDE-mac/kde/kf5-karchive"
  depends_on "KDE-mac/kde/kf5-kdoctools"
  depends_on "KDE-mac/kde/kf5-kio"
  depends_on "KDE-mac/kde/kf5-kparts"
  depends_on "KDE-mac/kde/kf5-kwallet"
  depends_on "KDE-mac/kde/kf5-kxmlgui"
  depends_on "KDE-mac/kde/kio-extras"

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
      "#{bin}/dolphin.app/Contents/Info.plist"
  end

  def post_install
    mkdir_p HOMEBREW_PREFIX/"share/krusader"
    ln_sf HOMEBREW_PREFIX/"share/icons/breeze/breeze-icons.rcc", HOMEBREW_PREFIX/"share/krusader/icontheme.rcc"
  end

  test do
    system "false"
  end
end
