require_relative "../lib/cmake"

class Libksysguard < Formula
  desc "Libraries for ksysguard"
  homepage "https://apps.kde.org/ksysguard"
  url "https://download.kde.org/stable/plasma/5.26.2/libksysguard-5.26.2.tar.xz"
  sha256 "ba2d563ab4152faf91496d965d29b9d69daedfe26d152ad3ee0b37e6752b6b40"
  head "https://invent.kde.org/plasma/libksysguard.git", branch: "master"

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
