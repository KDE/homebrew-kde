require_relative "../lib/cmake"

class Kdialog < Formula
  desc "Utility for displaying dialog boxes from shell scripts"
  homepage "https://develop.kde.org/deploy/kdialog/"
  url "https://download.kde.org/stable/release-service/22.12.0/src/kdialog-22.12.0.tar.xz"
  sha256 "dcb640d29681a6ddccf7f9f296272c1cf06204e304c87ab6626a2af873f58262"
  head "https://invent.kde.org/utilities/kdialog.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kcoreaddons"
  depends_on "kde-mac/kde/kf5-kdbusaddons"
  depends_on "kde-mac/kde/kf5-kguiaddons"
  depends_on "kde-mac/kde/kf5-kiconthemes"
  depends_on "kde-mac/kde/kf5-kio"
  depends_on "kde-mac/kde/kf5-knotifications"
  depends_on "kde-mac/kde/kf5-ktextwidgets"
  depends_on "kde-mac/kde/kf5-kwindowsystem"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
    # # Extract Qt plugin path
    # qtpp = `#{Formula["qt@5"].bin}/qtpaths --plugin-dir`.chomp
    # system "/usr/libexec/PlistBuddy",
    #   "-c", "Add :LSEnvironment:QT_PLUGIN_PATH string \"#{qtpp}\:#{HOMEBREW_PREFIX}/lib/qt5/plugins\"",
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
