require_relative "../lib/cmake"

class Libksysguard < Formula
  desc "Libraries for ksysguard"
  homepage "https://apps.kde.org/ksysguard"
  url "https://download.kde.org/stable/plasma/5.27.10/libksysguard-5.27.10.tar.xz"
  sha256 "17fc33b028cb272391b68c46e93b2d806d8254e6af9399d61375d49041ff3ce5"
  head "https://invent.kde.org/plasma/libksysguard.git", branch: "master"

  disable! date: "2023-10-25", because: "depends on X11"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kio"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5SysGuard REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
