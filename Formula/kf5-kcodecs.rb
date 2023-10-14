require_relative "../lib/cmake"

class Kf5Kcodecs < Formula
  desc "String encoding library"
  homepage "https://api.kde.org/frameworks/kcodecs/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.111/kcodecs-5.111.0.tar.xz"
  sha256 "869345ce9192a7d8346dcc5e55bec67493776e8a3d2139668ad088548526a6b4"
  head "https://invent.kde.org/frameworks/kcodecs.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "gperf" => :build
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
    (testpath/"CMakeLists.txt").write("find_package(KF5Codecs REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
