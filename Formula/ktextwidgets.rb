require_relative "../lib/cmake"

class Ktextwidgets < Formula
  desc "Advanced text editing widgets"
  homepage "https://api.kde.org/frameworks/ktextwidgets/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.7/ktextwidgets-6.7.0.tar.xz"
  sha256 "23bb71450e39f437c06bd9af48e7893253c31ad10649b0901d0a8ec1ee18ae01"
  head "https://invent.kde.org/frameworks/ktextwidgets.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kcompletion"
  depends_on "kde-mac/kde/kiconthemes"
  depends_on "kde-mac/kde/kservice"
  depends_on "kde-mac/kde/sonnet"
  depends_on "qt@6"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  def caveats
    <<~EOS
      You need to take some manual steps in order to make this formula work:
        "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
    EOS
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF6TextWidgets REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
