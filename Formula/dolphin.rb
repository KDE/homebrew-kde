class Dolphin < Formula
  desc "KDE File Manager"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/release-service/20.04.0/src/dolphin-20.04.0.tar.xz"
  sha256 "3c5bb9dc0b5ba55c54eb1c13b123b34f3437c22424142cb7d1957b6ebe4ad5ba"
  head "git://anongit.kde.org/dolphin.git"

  depends_on "cmake" => [:build, :test]
  depends_on "kde-extra-cmake-modules" => [:build, :test]
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "KDE-mac/kde/kf5-breeze-icons"
  depends_on "KDE-mac/kde/kf5-kcmutils"
  depends_on "KDE-mac/kde/kf5-kdelibs4support"
  depends_on "KDE-mac/kde/kf5-kfilemetadata"
  depends_on "KDE-mac/kde/kf5-kinit"
  depends_on "KDE-mac/kde/kf5-knewstuff"
  depends_on "KDE-mac/kde/kf5-kparts"
  depends_on "KDE-mac/kde/kio-extras"

  depends_on "KDE-mac/kde/konsole" => :optional
  depends_on "ruby" => :optional

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
    mkdir_p HOMEBREW_PREFIX/"share/dolphin"
    ln_sf HOMEBREW_PREFIX/"share/icons/breeze/breeze-icons.rcc", HOMEBREW_PREFIX/"share/dolphin/icontheme.rcc"
  end

  def caveats
    <<~EOS
      You need to take some manual steps in order to make this formula work:
        "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
    EOS
  end

  test do
    assert `"#{bin}/dolphin.app/Contents/MacOS/dolphin" --help | grep -- --help` =~ /--help/
  end
end
