require_relative "../lib/cmake"

class Kf5Knotifyconfig < Formula
  desc "Configuration system for KNotify"
  homepage "https://api.kde.org/frameworks/knotifyconfig/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.88/knotifyconfig-5.88.0.tar.xz"
  sha256 "0033f594d93c7a23a4203dedaf3ab0b07e840862f85fe240b0b5171f4f39706c"
  head "https://invent.kde.org/frameworks/knotifyconfig.git", branch: "master"

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
