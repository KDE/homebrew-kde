require_relative "../lib/cmake"

class Kf5Kjobwidgets < Formula
  desc "Widgets for tracking KJob instances"
  homepage "https://api.kde.org/frameworks/kjobwidgets/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.116/kjobwidgets-5.116.0.tar.xz"
  sha256 "eac37f7d02183f8d4347ab1d86608ee66007a3482a061169e4808caf853dbe87"
  head "https://invent.kde.org/frameworks/kjobwidgets.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kcoreaddons"
  depends_on "kde-mac/kde/kf5-kwidgetsaddons"
  depends_on "qt@5"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5JobWidgets REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
