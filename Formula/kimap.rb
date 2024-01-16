require_relative "../lib/cmake"

class Kimap < Formula
  desc "Job-based API for interacting with IMAP servers"
  homepage "https://community.kde.org/KDE_PIM"
  url "https://download.kde.org/stable/release-service/23.08.5/src/kimap-23.08.5.tar.xz"
  sha256 "42fd2019aca7da1a35c0fcf52d956be2bf4fe2eda496f23c982aa890d845783d"
  head "https://invent.kde.org/pim/kimap.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kio"
  depends_on "kde-mac/kde/kmime"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5IMAP REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
