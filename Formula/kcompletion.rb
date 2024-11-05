require_relative "../lib/cmake"

class Kcompletion < Formula
  desc "Completion framework"
  homepage "https://api.kde.org/frameworks/kcompletion/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.7/kcompletion-6.7.0.tar.xz"
  sha256 "7ed5a96ab0d2ab17bb521ecaaf44d6ec6b7c9a3d6e09403360ba49b24d94560f"
  head "https://invent.kde.org/frameworks/kcompletion.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kcodecs"
  depends_on "kde-mac/kde/kconfig"
  depends_on "kde-mac/kde/kwidgetsaddons"
  depends_on "qt@6"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF6Completion REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
