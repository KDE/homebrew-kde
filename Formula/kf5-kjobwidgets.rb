require_relative "../lib/cmake"

class Kf5Kjobwidgets < Formula
  desc "Widgets for tracking KJob instances"
  homepage "https://api.kde.org/frameworks/kjobwidgets/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.86/kjobwidgets-5.86.0.tar.xz"
  sha256 "6b18a885e9eaa221309272d19a7c88fcd21ed85a6f83ec44b3ea12277c0ba74a"
  head "https://invent.kde.org/frameworks/kjobwidgets.git", branch: "master"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kcoreaddons"
  depends_on "kde-mac/kde/kf5-kwidgetsaddons"
  depends_on "qt@5"

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5JobWidgets REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
