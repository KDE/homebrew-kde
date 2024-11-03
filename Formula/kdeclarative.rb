require_relative "../lib/cmake"

class Kdeclarative < Formula
  desc "Provides integration of QML and KDE Frameworks"
  homepage "https://api.kde.org/frameworks/kdeclarative/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.7/kdeclarative-6.7.0.tar.xz"
  sha256 "f1f804f6bac2b229503cfd165ebd8ae093533888ae15e0e61474c6e328d535b9"
  head "https://invent.kde.org/frameworks/kdeclarative.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kio"
  depends_on "kde-mac/kde/kpackage"
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
