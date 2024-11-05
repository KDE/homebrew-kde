require_relative "../lib/cmake"

class Kpty < Formula
  desc "Pty abstraction"
  homepage "https://api.kde.org/frameworks/kpty/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.7/kpty-6.7.0.tar.xz"
  sha256 "42cc1b1f70ee0bdacd26812857d31047d218e1f585ac35fe9165908501a9946a"
  head "https://invent.kde.org/frameworks/kpty.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "gettext" => :build
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kcoreaddons"
  depends_on "ki18n"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF6Pty REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
