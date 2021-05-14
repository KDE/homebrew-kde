require_relative "../lib/cmake"

class Kf5Kbookmarks < Formula
  desc "Bookmarks management library"
  homepage "https://api.kde.org/frameworks/kbookmarks/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.82/kbookmarks-5.82.0.tar.xz"
  sha256 "792c25d7979a0d1a0f09d3e570388a55356b99d98e55f7588613c16fa8c99f72"
  head "https://invent.kde.org/frameworks/kbookmarks.git"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kxmlgui"

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Bookmarks REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
