require_relative "../lib/cmake"

class Kf6Kdeclarative < Formula
  desc "Provides integration of QML and KDE Frameworks"
  homepage "https://api.kde.org/frameworks/kdeclarative/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.5/kdeclarative-6.5.0.tar.xz"
  sha256 "b3c4152c972e3d53645f1c88757a78ce5b66fbf4ecb76e4d69df78d2ab38cf83"
  head "https://invent.kde.org/frameworks/kdeclarative.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf6-kio"
  depends_on "kde-mac/kde/kf6-kpackage"
  depends_on "libepoxy"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF6Declarative REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
