require_relative "../lib/cmake"

class Libkexiv2 < Formula
  desc "Library to manipulate pictures metadata"
  homepage "https://api.kde.org/libkexiv2/html/index.html"
  url "https://download.kde.org/stable/release-service/21.12.0/src/libkexiv2-21.12.0.tar.xz"
  sha256 "9064a900dbad287dbdf2b6dd6b1202695f9409706040b43c5cad3f77490afed6"
  head "https://invent.kde.org/graphics/libkexiv2.git", branch: "master"

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
