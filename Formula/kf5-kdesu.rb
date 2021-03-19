require_relative "../lib/cmake"

class Kf5Kdesu < Formula
  desc "Integration with su for elevated privileges"
  homepage "https://api.kde.org/frameworks/kdesu/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.79/kdesu-5.79.0.tar.xz"
  sha256 "81018fb3a53e00dd19a15b472d7189f96b0aa5481d8371f923666271f22d9fc2"
  head "https://invent.kde.org/frameworks/kdesu.git"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "gettext" => :build
  depends_on "graphviz" => :build
  depends_on "kde-extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kpty"
  depends_on "kde-mac/kde/kf5-kservice"

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Su REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
