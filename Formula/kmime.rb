require_relative "../lib/cmake"

class Kmime < Formula
  desc "Library for handling mail messages and newsgroup articles"
  homepage "https://community.kde.org/KDE_PIM"
  url "https://download.kde.org/stable/release-service/22.12.0/src/kmime-22.12.0.tar.xz"
  sha256 "b8a69e3696a59e023492bab8f2103852d49e32bd0e821be2c8ffac5bd79a7e88"
  head "https://invent.kde.org/pim/kmime.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "gettext" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kcodecs"
  depends_on "ki18n"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Mime REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
