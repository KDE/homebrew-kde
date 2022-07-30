require_relative "../lib/cmake"

class Kf5Libkleo < Formula
  desc "KDE PIM cryptographic library"
  homepage "https://api.kde.org/kdepim/libkleo/html/index.html"
  url "https://download.kde.org/stable/release-service/22.04.3/src/libkleo-22.04.3.tar.xz"
  sha256 "d76e6fd8740d17eea371c4052b17e98a7fdf77651d801a31701968f2455c665a"
  head "https://invent.kde.org/pim/libkleo.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build
  depends_on "boost" => :build
  depends_on "doxygen" => :build

  depends_on "qt@5"

  depends_on "kde-mac/kde/kf5-kitemmodels"
  depends_on "kde-mac/kde/kpimtextedit"
  depends_on "gpgme"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Libkleo REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
