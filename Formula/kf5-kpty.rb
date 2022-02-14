require_relative "../lib/cmake"

class Kf5Kpty < Formula
  desc "Pty abstraction"
  homepage "https://api.kde.org/frameworks/kpty/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.92/kpty-5.92.0.tar.xz"
  sha256 "cb1dac5f8f7ba059ef967a2cf3d1580a29a8d7b373ef67e82e0ac4f0285ee052"
  head "https://invent.kde.org/frameworks/kpty.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "gettext" => :build
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kcoreaddons"
  depends_on "ki18n"

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Pty REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
