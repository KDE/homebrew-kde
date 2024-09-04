require_relative "../lib/cmake"

class Kf6Ktextwidgets < Formula
  desc "Advanced text editing widgets"
  homepage "https://api.kde.org/frameworks/ktextwidgets/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.5/ktextwidgets-6.5.0.tar.xz"
  sha256 "a99df1c634831e9d01f704009c951378108334a4258ad5b64f60f55e55770212"
  head "https://invent.kde.org/frameworks/ktextwidgets.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf6-kcompletion"
  depends_on "kde-mac/kde/kf6-kiconthemes"
  depends_on "kde-mac/kde/kf6-kservice"
  depends_on "kde-mac/kde/kf6-sonnet"
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
