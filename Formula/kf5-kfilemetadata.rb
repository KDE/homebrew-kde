require_relative "../lib/cmake"

class Kf5Kfilemetadata < Formula
  desc "Library for extracting file metadata"
  homepage "https://api.kde.org/frameworks/kfilemetadata/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.100/kfilemetadata-5.100.0.tar.xz"
  sha256 "6fb20c163dc21ee6f89cff4be6cd3939e49ffb2fa61e02a5bcc7b51d13567131"
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
  depends_on "kde-mac/kde/kf5-kconfig"
  depends_on "kde-mac/kde/kf5-kcoreaddons"
  depends_on "ki18n"
  depends_on "poppler-qt5"
  depends_on "taglib"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5FileMetaData REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
