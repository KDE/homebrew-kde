require_relative "../lib/cmake"

class Kf5Kdesu < Formula
  desc "Integration with su for elevated privileges"
  homepage "https://api.kde.org/frameworks/kdesu/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.90/kdesu-5.90.0.tar.xz"
  sha256 "970707b7717d8a3c38687f40ff93809b3779e527d8a6ce5fe2df05c20e1613e1"
  head "https://invent.kde.org/frameworks/kdesu.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "gettext" => :build
  depends_on "graphviz" => :build
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
