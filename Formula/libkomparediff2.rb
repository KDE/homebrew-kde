require_relative "../lib/cmake"

class Libkomparediff2 < Formula
  desc "Library to compare files and strings"
  homepage "https://invent.kde.org/sdk/libkomparediff2"
  url "https://download.kde.org/stable/release-service/21.12.3/src/libkomparediff2-21.12.3.tar.xz"
  sha256 "a2815b6c9fc08172b4e39b27c25764baa96de40d6ca298544085fba692a323c9"
  head "https://invent.kde.org/sdk/libkomparediff2.git", branch: "master"

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
