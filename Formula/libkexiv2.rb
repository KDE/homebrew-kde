require_relative "../lib/cmake"

class Libkexiv2 < Formula
  desc "Library to manipulate pictures metadata"
  homepage "https://api.kde.org/libkexiv2/html/index.html"
  url "https://download.kde.org/stable/release-service/21.04.3/src/libkexiv2-21.04.3.tar.xz"
  sha256 "406fcd2fc5402250608d4a842f07b39edf82f7a9fb77d0d3bf4caf47b83de39f"
  head "https://invent.kde.org/graphics/libkexiv2.git"

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
