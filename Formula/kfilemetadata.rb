require_relative "../lib/cmake"

class Kfilemetadata < Formula
  desc "Library for extracting file metadata"
  homepage "https://api.kde.org/frameworks/kfilemetadata/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.7/kfilemetadata-6.7.0.tar.xz"
  sha256 "a6242a79e672b523ebf1b2554ebf83aca7a9d5065929b6f152731e9851d008d0"
  head "https://invent.kde.org/frameworks/kfilemetadata.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "ebook-tools"
  depends_on "exiv2"
  depends_on "ffmpeg"
  depends_on "karchive"
  depends_on "kde-mac/kde/kcodecs"
  depends_on "kde-mac/kde/kconfig"
  depends_on "kde-mac/kde/kcoreaddons"
  depends_on "ki18n"
  depends_on "poppler"
  depends_on "taglib"
  #  depends_on "catdoc"
  #  depends_on "kdegraphics-mobipocket"
  #  depends_on "libappimage"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF6FileMetaData REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
