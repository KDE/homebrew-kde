require_relative "../lib/cmake"

class Kf5Kpty < Formula
  desc "Pty abstraction"
  homepage "https://api.kde.org/frameworks/kpty/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.115/kpty-5.115.0.tar.xz"
  sha256 "844c03068b266fa0805a015af2752923b42d55e8d9d4d65b3e600a19a2805419"
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
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Pty REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
