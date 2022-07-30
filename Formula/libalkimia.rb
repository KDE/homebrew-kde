require_relative "../lib/cmake"

class Libalkimia < Formula
  desc "Library used by KDE Finance applications"
  homepage "https://kmymoney.org"
  url "https://download.kde.org/stable/alkimia/8.1.1/alkimia-8.1.1.tar.xz"
  sha256 "957adc63c0be54dd433e3268a37323be5456e5ab84ece27f73a1616a92db86d5"
  revision 1
  head "https://invent.kde.org/office/alkimia.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "gettext"
  depends_on "gmp"
  depends_on "kde-mac/kde/kf5-kcoreaddons"
  depends_on "kde-mac/kde/kf5-knewstuff"

  def install
    system "cmake", "-DBUILD_APPLETS=OFF", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(LibAlkimia5 REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
