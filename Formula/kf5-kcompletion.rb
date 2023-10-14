require_relative "../lib/cmake"

class Kf5Kcompletion < Formula
  desc "Completion framework"
  homepage "https://api.kde.org/frameworks/kcompletion/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.111/kcompletion-5.111.0.tar.xz"
  sha256 "537d1213be9d75e38044565e9a713d52b989be89dd9f92f9d288e9e57a0f2fba"
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
