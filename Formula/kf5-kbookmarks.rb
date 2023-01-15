require_relative "../lib/cmake"

class Kf5Kbookmarks < Formula
  desc "Bookmarks management library"
  homepage "https://api.kde.org/frameworks/kbookmarks/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.102/kbookmarks-5.102.0.tar.xz"
  sha256 "9a9ee8dc87148649457f40e5f47055d66ec7168d27a8f8a19a6cb655ce4fe9c9"
  head "https://invent.kde.org/frameworks/kbookmarks.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kxmlgui"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Bookmarks REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
