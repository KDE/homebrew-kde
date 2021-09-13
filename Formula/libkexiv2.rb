require_relative "../lib/cmake"

class Libkexiv2 < Formula
  desc "Library to manipulate pictures metadata"
  homepage "https://api.kde.org/libkexiv2/html/index.html"
  url "https://download.kde.org/stable/release-service/21.08.1/src/libkexiv2-21.08.1.tar.xz"
  sha256 "aa1332b4d6abb25372103af72008b7081fd09928a9d816daf8c595b5e39fd772"
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
