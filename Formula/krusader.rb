require_relative "../lib/cmake"

class Krusader < Formula
  desc "Advanced twin panel (commander style) file manager"
  homepage "https://krusader.org/"
  url "https://download.kde.org/stable/krusader/2.8.1/krusader-2.8.1.tar.xz"
  sha256 "37bf204519d0ab1ba40964af02741bc228f11e97f28c4c518ca05d358df18283"
  head "https://invent.kde.org/utilities/krusader.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "gettext"
  depends_on "hicolor-icon-theme"
  depends_on "karchive"
  depends_on "kde-mac/kde/kio"
  depends_on "kde-mac/kde/kio-extras"
  depends_on "kde-mac/kde/kparts"
  depends_on "kde-mac/kde/kwallet"
  depends_on "kde-mac/kde/kxmlgui"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
    # Extract Qt plugin path
    qtpp = `#{Formula["qt@6"].bin}/qtpaths --plugin-dir`.chomp
    system "/usr/libexec/PlistBuddy",
      "-c", "Add :LSEnvironment:QT_PLUGIN_PATH string \"#{qtpp}\"",
      "#{bin}/krusader.app/Contents/Info.plist"
  end

  def post_install
    mkdir_p HOMEBREW_PREFIX/"share/krusader"
    ln_sf HOMEBREW_PREFIX/"share/icons/breeze/breeze-icons.rcc", HOMEBREW_PREFIX/"share/krusader/icontheme.rcc"
  end

  def caveats
    <<~EOS
      You need to take some manual steps in order to make this formula work:
        "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
    EOS
  end

  test do
    assert_match "help", shell_output("#{bin}/krusader.app/Contents/MacOS/krusader --help")
  end
end
