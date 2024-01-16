require_relative "../lib/cmake"

class Kf5Kjobwidgets < Formula
  desc "Widgets for tracking KJob instances"
  homepage "https://api.kde.org/frameworks/kjobwidgets/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.115/kjobwidgets-5.115.0.tar.xz"
  sha256 "cee37be8d309cc572ecf572214d9138183fd07e6aee2af77fb60f37ebe4e3061"
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
