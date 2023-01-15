require_relative "../lib/cmake"

class Kimap < Formula
  desc "Job-based API for interacting with IMAP servers"
  homepage "https://community.kde.org/KDE_PIM"
  url "https://download.kde.org/stable/release-service/22.12.1/src/kimap-22.12.1.tar.xz"
  sha256 "bdd908dd96638f244b2c27afc461df51b04faba790eda946c8017f44058acf0d"
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
