require_relative "../lib/cmake"

class Kjobwidgets < Formula
  desc "Widgets for tracking KJob instances"
  homepage "https://api.kde.org/frameworks/kjobwidgets/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.7/kjobwidgets-6.7.0.tar.xz"
  sha256 "16d7e7ab54235d6fa1eb213d3d637182e22fcbdbcb7b4b14032430a02a2f888a"
  head "https://invent.kde.org/frameworks/kjobwidgets.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kcoreaddons"
  depends_on "kde-mac/kde/kwidgetsaddons"
  depends_on "kde-mac/kde/knotifications"
  depends_on "qt@6"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF6JobWidgets REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
