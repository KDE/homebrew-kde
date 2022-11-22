require_relative "../lib/cmake"

class Kf5Kcompletion < Formula
  desc "Completion framework"
  homepage "https://api.kde.org/frameworks/kcompletion/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.100/kcompletion-5.100.0.tar.xz"
  sha256 "63689d9bad9c7320734e84c5b6434aa11c15b026c845ae05f5ce154afd0a4586"
  head "https://invent.kde.org/frameworks/kcompletion.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kconfig"
  depends_on "kde-mac/kde/kf5-kwidgetsaddons"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Completion REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
