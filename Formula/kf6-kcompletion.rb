require_relative "../lib/cmake"

class Kf6Kcompletion < Formula
  desc "Completion framework"
  homepage "https://api.kde.org/frameworks/kcompletion/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.5/kcompletion-6.5.0.tar.xz"
  sha256 "778af80e5015f49ce1e1dde6180bf51167a1f5dfb12d07c73216b5fa804eedf9"
  head "https://invent.kde.org/frameworks/kcompletion.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "qt@6"
  depends_on "kde-mac/kde/kf6-kcodecs"
  depends_on "kde-mac/kde/kf6-kconfig"
  depends_on "kde-mac/kde/kf6-kwidgetsaddons"

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
