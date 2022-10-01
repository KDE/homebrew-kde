require_relative "../lib/cmake"

class Libkomparediff2 < Formula
  desc "Library to compare files and strings"
  homepage "https://invent.kde.org/sdk/libkomparediff2"
  url "https://download.kde.org/stable/release-service/22.08.1/src/libkomparediff2-22.08.1.tar.xz"
  sha256 "694f535f77a803c18c11bd9754b253c037a70f3a78ab20102d4037b01dec5d42"
  head "https://invent.kde.org/sdk/libkomparediff2.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kio"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(LibKompareDiff2 REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
