require_relative "../lib/cmake"

class Kf5Knotifyconfig < Formula
  desc "Configuration system for KNotify"
  homepage "https://api.kde.org/frameworks/knotifyconfig/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.85/knotifyconfig-5.85.0.tar.xz"
  sha256 "dbd51384750c62881d0435db13a278dfb4699b31aa0c83a6cbbf7e924facf0aa"
  head "https://invent.kde.org/frameworks/knotifyconfig.git"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kio"

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5NotifiConfig REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
