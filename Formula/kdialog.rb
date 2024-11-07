require_relative "../lib/cmake"

class Kdialog < Formula
  desc "Utility for displaying dialog boxes from shell scripts"
  homepage "https://develop.kde.org/deploy/kdialog/"
  url "https://download.kde.org/stable/release-service/24.08.3/src/kdialog-24.08.3.tar.xz"
  sha256 "781a2e9b456563f06d9a2c0d3feac54f156b6b8d0d18094aa2b7a1cb45796fc3"
  head "https://invent.kde.org/utilities/kdialog.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kcoreaddons"
  depends_on "kde-mac/kde/kdbusaddons"
  depends_on "kde-mac/kde/kguiaddons"
  depends_on "kde-mac/kde/kiconthemes"
  depends_on "kde-mac/kde/kio"
  depends_on "kde-mac/kde/knotifications"
  depends_on "kde-mac/kde/ktextwidgets"
  depends_on "kde-mac/kde/kwindowsystem"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
    # # Extract Qt plugin path
    # qtpp = `#{Formula["qt@6"].bin}/qtpaths --plugin-dir`.chomp
    # system "/usr/libexec/PlistBuddy",
    #   "-c", "Add :LSEnvironment:QT_PLUGIN_PATH string \"#{qtpp}\",
    #   "#{bin}/dolphin.app/Contents/Info.plist"
  end

  # def post_install
  #   mkdir_p HOMEBREW_PREFIX/"share/dolphin"
  #   ln_sf HOMEBREW_PREFIX/"share/icons/breeze/breeze-icons.rcc", HOMEBREW_PREFIX/"share/dolphin/icontheme.rcc"
  # end

  def caveats
    <<~EOS
      You need to take some manual steps in order to make this formula work:
        "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
    EOS
  end

  test do
    assert_match "help", shell_output("#{bin}/kdialog.app/Contents/MacOS/kdialog --help")
  end
end
