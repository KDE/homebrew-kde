require_relative "../lib/cmake"

class Kf5Kconfigwidgets < Formula
  desc "Widgets for configuration dialogs"
  homepage "https://api.kde.org/frameworks/kconfigwidgets/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.84/kconfigwidgets-5.84.0.tar.xz"
  sha256 "36ea5e2263776f988a9b2301f4605ccb4b3683afbe770c1896a5525e12711e9e"
  head "https://invent.kde.org/frameworks/kconfigwidgets.git"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "gettext" => :build
  depends_on "graphviz" => :build
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kauth"
  depends_on "kde-mac/kde/kf5-kcodecs"
  depends_on "kde-mac/kde/kf5-kconfig"
  depends_on "kde-mac/kde/kf5-kguiaddons"
  depends_on "kde-mac/kde/kf5-kwidgetsaddons"
  depends_on "ki18n"

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5ConfigWidgets REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
