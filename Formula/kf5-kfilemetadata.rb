require_relative "../lib/cmake"

class Kf5Kfilemetadata < Formula
  desc "Library for extracting file metadata"
  homepage "https://api.kde.org/frameworks/kfilemetadata/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.84/kfilemetadata-5.84.0.tar.xz"
  sha256 "d170999ab1bfd3d4763453f987061292f9feae8e6f0174fc7eb2ef03ada646a5"
  head "https://invent.kde.org/frameworks/kfilemetadata.git"

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
  depends_on "poppler"
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
