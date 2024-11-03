require_relative "../lib/cmake"

class Kcodecs < Formula
  desc "String encoding library"
  homepage "https://api.kde.org/frameworks/kcodecs/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.7/kcodecs-6.7.0.tar.xz"
  sha256 "9ab494055e06bdce45568b7c47edb2aa9ecaa9dec0c0fb152367b4321921b9f2"
  head "https://invent.kde.org/frameworks/kcodecs.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "gperf" => :build
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "qt@6"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF6Codecs REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
