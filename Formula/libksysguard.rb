require_relative "../lib/cmake"

class Libksysguard < Formula
  desc "Libraries for ksysguard"
  homepage "https://apps.kde.org/ksysguard"
  url "https://download.kde.org/stable/plasma/5.23.2/libksysguard-5.23.2.tar.xz"
  sha256 "f8fabf6af590e92146d1449e96a66ea7e5b7c249699ec0fe0e612f91c78ccbce"
  head "https://invent.kde.org/plasma/libksysguard.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "kde-mac/kde/kf5-plasma-framework" => :build
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kio"

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5SysGuard REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
