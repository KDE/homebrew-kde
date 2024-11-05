require_relative "../lib/cmake"

class Kcolorscheme < Formula
  desc "Support for color themes"
  homepage "https://api.kde.org/frameworks/kcolorscheme/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.7/kcolorscheme-6.7.0.tar.xz"
  sha256 "1b4c6e84f1dd96b2ee62be755f60da60d61ba80d6709eeb3186d8882e72e2130"
  head "https://invent.kde.org/frameworks/kcolorscheme.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "gettext" => :build
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kconfig"
  depends_on "kde-mac/kde/kguiaddons"
  depends_on "ki18n"
  depends_on "qt@6"

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
