require_relative "../lib/cmake"

class Kile < Formula
  desc "Integrated LaTeX Editing Environment"
  homepage "https://kile.sourceforge.io"
  url "https://downloads.sourceforge.net/project/kile/unstable/kile-3.0b3/kile-2.9.93.tar.bz2"
  sha256 "04499212ffcb24fb3a6829149a7cae4c6ad5d795985f080800d6df72f88c5df0"
  revision 1
  head "https://invent.kde.org/office/kile.git"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "cmake" => :build
  depends_on "extra-cmake-modules" => :build
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kinit"
  depends_on "kde-mac/kde/kf5-ktexteditor"
  depends_on "kde-mac/kde/konsole"
  depends_on "kde-mac/kde/okular"

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "."
    system "cmake", "--install", "."
    prefix.install "build/install_manifest.txt"

    # Extract Qt plugin path
    qtpp = `#{Formula["qt"].bin}/qtpaths --plugin-dir`.chomp
    system "/usr/libexec/PlistBuddy",
      "-c", "Add :LSEnvironment:QT_PLUGIN_PATH string \"#{qtpp}\:#{HOMEBREW_PREFIX}/lib/qt5/plugins\"",
      "#{bin}/kile.app/Contents/Info.plist"
  end

  def caveats
    <<~EOS
      You need to take some manual steps in order to make this formula work:
       "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
    EOS
  end

  test do
    assert_match "help", shell_output("#{bin}/kile.app/Contents/MacOS/Kile --help")
  end
end
