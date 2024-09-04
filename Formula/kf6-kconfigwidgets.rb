require_relative "../lib/cmake"

class Kf6Kconfigwidgets < Formula
  desc "Widgets for configuration dialogs"
  homepage "https://api.kde.org/frameworks/kconfigwidgets/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.5/kconfigwidgets-6.5.0.tar.xz"
  sha256 "a4804683fc0477fb505c410444164bf2803ffc216d221609a0be5842803e5612"
  head "https://invent.kde.org/frameworks/kconfigwidgets.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "gettext" => :build
  depends_on "graphviz" => :build
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf6-kauth"
  depends_on "kde-mac/kde/kf6-kcodecs"
  depends_on "kde-mac/kde/kf6-kcolorscheme"
  depends_on "kde-mac/kde/kf6-kconfig"
  depends_on "kde-mac/kde/kf6-kguiaddons"
  depends_on "kde-mac/kde/kf6-kwidgetsaddons"
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
