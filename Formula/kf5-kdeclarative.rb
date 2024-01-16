require_relative "../lib/cmake"

class Kf5Kdeclarative < Formula
  desc "Provides integration of QML and KDE Frameworks"
  homepage "https://api.kde.org/frameworks/kdeclarative/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.115/kdeclarative-5.115.0.tar.xz"
  sha256 "66ecac06ea2226f75be84ceacf447b4cdd26685d0161cc32e2e01d216303a344"
  head "https://invent.kde.org/frameworks/kdeclarative.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kio"
  depends_on "kde-mac/kde/kf5-kpackage"
  depends_on "libepoxy"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Declarative REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
