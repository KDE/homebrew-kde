require_relative "../lib/cmake"

class Kf5Kinit < Formula
  desc "Process launcher to speed up launching KDE applications"
  homepage "https://api.kde.org/frameworks/kinit/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.116/kinit-5.116.0.tar.xz"
  sha256 "e4a4acc661035d22f7636397d23307c2e4e4129a7ed82d458fdf2f7ee63dbc2c"
  head "https://invent.kde.org/frameworks/kinit.git", branch: "master"

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
    (testpath/"CMakeLists.txt").write("find_package(KF5Init REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
