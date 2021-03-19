require_relative "../lib/cmake"

class Libkomparediff2 < Formula
  desc "Library to compare files and strings"
  homepage "https://invent.kde.org/sdk/libkomparediff2"
  url "https://download.kde.org/stable/release-service/20.12.2/src/libkomparediff2-20.12.2.tar.xz"
  sha256 "a98555dd0a8ee86c08db3f0f20d50de0f4f82e77e7ba2fcf643b7e88031dd60d"
  head "https://invent.kde.org/sdk/libkomparediff2.git"

  depends_on "cmake" => [:build, :test]
  depends_on "kde-extra-cmake-modules" => [:build, :test]
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
