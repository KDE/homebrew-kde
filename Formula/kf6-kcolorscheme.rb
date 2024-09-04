require_relative "../lib/cmake"

class Kf6Kcolorscheme < Formula
  desc "Support for color themes"
  homepage "https://api.kde.org/frameworks/kcolorthemes/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.5/kcolorscheme-6.5.0.tar.xz"
  sha256 "323b55dd37dc408ccc158df2ce5c8a46b628f9355d2a77916e4565afce90b42b"
  head "https://invent.kde.org/frameworks/kcolorscheme.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "gettext" => :build
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "qt@6"
  depends_on "kde-mac/kde/kf6-kconfig"
  depends_on "kde-mac/kde/kf6-kguiaddons"
  depends_on "ki18n"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF6ColorScheme REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
