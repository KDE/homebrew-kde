require_relative "../lib/cmake"

class Kconfigwidgets < Formula
  desc "Widgets for configuration dialogs"
  homepage "https://api.kde.org/frameworks/kconfigwidgets/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.7/kconfigwidgets-6.7.0.tar.xz"
  sha256 "c079c67c578930baafae241bb4f252c63fdd125e44f1fb952e39bae3c9859cd1"
  head "https://invent.kde.org/frameworks/kconfigwidgets.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "gettext" => :build
  depends_on "graphviz" => :build
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kauth"
  depends_on "kde-mac/kde/kcodecs"
  depends_on "kde-mac/kde/kcolorscheme"
  depends_on "kde-mac/kde/kconfig"
  depends_on "kde-mac/kde/kguiaddons"
  depends_on "kde-mac/kde/kwidgetsaddons"
  depends_on "ki18n"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF6ConfigWidgets REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
