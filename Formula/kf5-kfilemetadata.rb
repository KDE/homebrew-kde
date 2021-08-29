require_relative "../lib/cmake"

class Kf5Kfilemetadata < Formula
  desc "Library for extracting file metadata"
  homepage "https://api.kde.org/frameworks/kfilemetadata/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.85/kfilemetadata-5.85.0.tar.xz"
  sha256 "3d4ee4bfe3856917671c5f8c3c0f43b70e7ddee952f0afb4a8105749e217251e"
  revision 1
  head "https://invent.kde.org/frameworks/kfilemetadata.git", branch: "master"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "ebook-tools"
  depends_on "exiv2"
  depends_on "ffmpeg"
  depends_on "karchive"
  depends_on "kde-mac/kde/kf5-kconfig"
  depends_on "kde-mac/kde/kf5-kcoreaddons"
  depends_on "ki18n"
  depends_on "poppler-qt5"
  depends_on "taglib"

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5FileMetaData REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
