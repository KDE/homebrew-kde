require_relative "../lib/cmake"

class Libkexiv2 < Formula
  desc "Library to manipulate pictures metadata"
  homepage "https://api.kde.org/libkexiv2/html/index.html"
  url "https://download.kde.org/stable/release-service/22.08.3/src/libkexiv2-22.08.3.tar.xz"
  sha256 "8dafd704ab51e6078a284ec9b80a9101c770dd6603664c113f2805e291d8afd1"
  head "https://invent.kde.org/graphics/libkexiv2.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "exiv2"
  depends_on "qt@5"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5KExiv2 REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
