require_relative "../lib/cmake"

class Ktorrent < Formula
  desc "Powerful BitTorrent client for KDE"
  homepage "https://kde.org/applications/internet/ktorrent/"
  url "https://download.kde.org/stable/ktorrent/5.2.0/ktorrent-5.2.0.tar.xz"
  sha256 "d1031d745c1ace02d11b59c426610aee779d208e3d1ae81f8559c265173732ff"
  head "https://invent.kde.org/network/ktorrent.git"

  livecheck do
    skip "Newer versions doesn't compile due to bug: https://bugs.kde.org/show_bug.cgi?id=430896"
    # url :head
    # regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "boost" => :build
  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-breeze-icons"
  depends_on "kde-mac/kde/kf5-kcmutils"
  depends_on "kde-mac/kde/kf5-kio"
  depends_on "kde-mac/kde/kf5-knotifyconfig"
  depends_on "kde-mac/kde/kf5-kross"
  depends_on "kde-mac/kde/libktorrent"

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
    # Extract Qt plugin path
    qtpp = `#{Formula["qt@5"].bin}/qtpaths --plugin-dir`.chomp
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

  def caveats
    <<~EOS
      You need to take some manual steps in order to make this formula work:
        "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
    EOS
  end

  test do
    assert_match "help", shell_output("#{bin}/ktorrent.app/Contents/MacOS/ktorrent --help")
    assert_match "help", shell_output("#{bin}/ktupnptest.app/Contents/MacOS/ktupnptest --help")
  end
end
