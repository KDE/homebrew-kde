require_relative "../lib/cmake"

class Kf6Kdoctools < Formula
  desc "Support for unit conversion"
  homepage "https://api.kde.org/frameworks/kdoctools/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.5/kdoctools-6.5.0.tar.xz"
  sha256 "781e1ae222ee1e54cc6310412c3709e0c33e1c4ff82470d2960d6e5daa6001dd"
  head "https://invent.kde.org/frameworks/kunitconversion.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "gettext" => :build
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "qt@6"
  depends_on "ki18n"
  depends_on "libxslt"
  depends_on "libxml2"
  depends_on "docbook-xsl"
  depends_on "kde-mac/kde/kf6-kcoreaddons"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF6DocTools REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
