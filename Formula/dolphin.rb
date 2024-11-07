require_relative "../lib/cmake"

class Dolphin < Formula
  desc "KDE File Manager"
  homepage "https://apps.kde.org/dolphin"
  url "https://download.kde.org/stable/release-service/24.08.3/src/dolphin-24.08.3.tar.xz"
  sha256 "95bbce876019fb0c7cc6ca4a5fd8ec1f625f70fd511fe883df12446a5285806d"
  head "https://invent.kde.org/system/dolphin.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/breeze-icons"
  depends_on "kde-mac/kde/kcmutils"
  depends_on "kde-mac/kde/kf5-kactivities"
  depends_on "kde-mac/kde/kf5-kinit"
  depends_on "kde-mac/kde/kfilemetadata"
  depends_on "kde-mac/kde/kio-extras"
  depends_on "kde-mac/kde/knewstuff"
  depends_on "kde-mac/kde/konsole"
  depends_on "kde-mac/kde/kparts"
  depends_on "ruby"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
    # Extract Qt plugin path
    qtpp = `#{Formula["qt@6"].bin}/qtpaths --plugin-dir`.chomp
    system "/usr/libexec/PlistBuddy",
      "-c", "Add :LSEnvironment:QT_PLUGIN_PATH string \"#{qtpp}\"",
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
    assert_match "help", shell_output("#{bin}/dolphin.app/Contents/MacOS/dolphin --help")
  end
end
