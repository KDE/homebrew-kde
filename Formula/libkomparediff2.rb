require_relative "../lib/cmake"

class Libkomparediff2 < Formula
  desc "Library to compare files and strings"
  homepage "https://invent.kde.org/sdk/libkomparediff2"
  url "https://download.kde.org/stable/release-service/21.08.2/src/libkomparediff2-21.08.2.tar.xz"
  sha256 "1d84be7b279c170783a6a49525e9b9d67be3d20e376d41b057ba4440e3b8c923"
  head "https://invent.kde.org/sdk/libkomparediff2.git", branch: "master"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kio"

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(LibKompareDiff2 REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
