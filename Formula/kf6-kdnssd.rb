require_relative "../lib/cmake"

class Kf6Kdnssd < Formula
  desc "Abstraction to system DNSSD features"
  homepage "https://api.kde.org/frameworks/kdnssd/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.5/kdnssd-6.5.0.tar.xz"
  sha256 "37fd254c39b66fca1b52f898c045f322a0ea3177c927941979ccb7b9b98ebffd"
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
