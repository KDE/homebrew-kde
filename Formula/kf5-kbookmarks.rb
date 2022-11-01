require_relative "../lib/cmake"

class Kf5Kbookmarks < Formula
  desc "Bookmarks management library"
  homepage "https://api.kde.org/frameworks/kbookmarks/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.99/kbookmarks-5.99.0.tar.xz"
  sha256 "b5b82d3fda366a2bcada2500ee7f727c1eda0c4218330511ae58993893c1686d"
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
