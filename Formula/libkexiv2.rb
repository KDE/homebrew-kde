require_relative "../lib/cmake"

class Libkexiv2 < Formula
  desc "Library to manipulate pictures metadata"
  homepage "https://api.kde.org/libkexiv2/html/index.html"
  url "https://download.kde.org/stable/release-service/21.08.2/src/libkexiv2-21.08.2.tar.xz"
  sha256 "6adfeed75f35e956dc602d97c033e15af33241200c7c51b7fdf66693d735ea6a"
  head "https://invent.kde.org/graphics/libkexiv2.git", branch: "master"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "exiv2"
  depends_on "qt@5"

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5KExiv2 REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
