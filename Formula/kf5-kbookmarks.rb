require_relative "../lib/cmake"

class Kf5Kbookmarks < Formula
  desc "Bookmarks management library"
  homepage "https://api.kde.org/frameworks/kbookmarks/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.95/kbookmarks-5.95.0.tar.xz"
  sha256 "77fa9ac736d9aebe34da5b96fb377500e1395b5cd88c64256881193be53a55f0"
  head "https://invent.kde.org/frameworks/kbookmarks.git", branch: "master"

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
