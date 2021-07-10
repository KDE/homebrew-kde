require_relative "../lib/cmake"

class Kf5Attica < Formula
  desc "Open Collaboration Service client library"
  homepage "https://api.kde.org/frameworks/attica/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.84/attica-5.84.0.tar.xz"
  sha256 "adb8afbbe73d89e07dee77a4ee0d9553b4611ee5e69effe9e0d9881b54abb1e0"
  head "https://invent.kde.org/frameworks/attica.git"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
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
    (testpath/"CMakeLists.txt").write("find_package(KF5Attica REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
