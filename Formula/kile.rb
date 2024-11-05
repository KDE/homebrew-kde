require_relative "../lib/cmake"

class Kile < Formula
  desc "Integrated LaTeX Editing Environment"
  homepage "https://kile.sourceforge.io"
  url "https://downloads.sourceforge.net/project/kile/unstable/kile-3.0b4/kile-2.9.94-1.tar.bz2"
  sha256 "64fa2e45c97dbb6f613d10f7f9bb005bf86fbbaaff238185538ac5b896be632f"
  head "https://invent.kde.org/office/kile.git", branch: "master"

  depends_on "cmake" => :build
  depends_on "extra-cmake-modules" => :build
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-khtml"
  depends_on "kde-mac/kde/kf5-kinit"
  depends_on "kde-mac/kde/ktexteditor"
  depends_on "kde-mac/kde/okular"

  depends_on "kde-mac/kde/konsole" => :recommended
  depends_on "poppler-qt5" => :recommended

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"

    # Extract Qt plugin path
    qtpp = `#{Formula["qt@5"].bin}/qtpaths --plugin-dir`.chomp
    system "/usr/libexec/PlistBuddy",
      "-c", "Add :LSEnvironment:QT_PLUGIN_PATH string \"#{qtpp}:#{HOMEBREW_PREFIX}/lib/qt5/plugins\"",
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
