require_relative "../lib/cmake"

class Kf5Kbookmarks < Formula
  desc "Bookmarks management library"
  homepage "https://api.kde.org/frameworks/kbookmarks/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.79/kbookmarks-5.79.0.tar.xz"
  sha256 "0dcfdf8b2f1d6cebdf830adc338d07a10cf2ddca815c21365cf5ec8e67943981"
  head "https://invent.kde.org/frameworks/kbookmarks.git"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "kde-extra-cmake-modules" => [:build, :test]
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
