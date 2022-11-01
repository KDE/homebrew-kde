require_relative "../lib/cmake"

class Kf5Kitemviews < Formula
  desc "Widget addons for Qt Model/View"
  homepage "https://api.kde.org/frameworks/kitemviews/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.99/kitemviews-5.99.0.tar.xz"
  sha256 "1161d0ed34142fcaf6bc15d26dd91f2d593e4094023570c6fb13df253548f98d"
  head "https://invent.kde.org/frameworks/kitemviews.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "qt@5"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5ItemViews REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
