require_relative "../lib/cmake"

class Kf5Kdnssd < Formula
  desc "Abstraction to system DNSSD features"
  homepage "https://api.kde.org/frameworks/kdnssd/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.83/kdnssd-5.83.0.tar.xz"
  sha256 "6ff550e4d97d77d8e46bc6f76dfbcfcb2e2264f43144c5f9aaed7e191f502285"
  head "https://invent.kde.org/frameworks/kdnssd.git"

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
    (testpath/"CMakeLists.txt").write("find_package(KF5DNSSD REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
