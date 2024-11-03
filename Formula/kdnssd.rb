require_relative "../lib/cmake"

class Kdnssd < Formula
  desc "Abstraction to system DNSSD features"
  homepage "https://api.kde.org/frameworks/kdnssd/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.7/kdnssd-6.7.0.tar.xz"
  sha256 "e9140475fc6e4ee1e0fe39a21816a3c003fcb1092222079f422fd02ad2a902a1"
  head "https://invent.kde.org/frameworks/kdnssd.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
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
    (testpath/"CMakeLists.txt").write("find_package(KF6DNSSD REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
