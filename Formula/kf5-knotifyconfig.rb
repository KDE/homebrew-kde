require_relative "../lib/cmake"

class Kf5Knotifyconfig < Formula
  desc "Configuration system for KNotify"
  homepage "https://api.kde.org/frameworks/knotifyconfig/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.100/knotifyconfig-5.100.0.tar.xz"
  sha256 "1db5a4c4f0a8a4c1ff1db5df07d601dc63714720e4c5e52052811004bc27baa9"
  head "https://invent.kde.org/frameworks/knotifyconfig.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kio"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5NotifiConfig REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
