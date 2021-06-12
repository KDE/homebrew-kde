require_relative "../lib/cmake"

class Kf5Kcodecs < Formula
  desc "String encoding library"
  homepage "https://api.kde.org/frameworks/kcodecs/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.83/kcodecs-5.83.0.tar.xz"
  sha256 "02352cabd76a02c8c843b31d5ad8be208af7d17705cbcfca75733b5e3e518359"
  head "https://invent.kde.org/frameworks/kcodecs.git"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "gperf" => :build
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "qt@5"

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Codecs REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
