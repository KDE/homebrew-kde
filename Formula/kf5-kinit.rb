require_relative "../lib/cmake"

class Kf5Kinit < Formula
  desc "Process launcher to speed up launching KDE applications"
  homepage "https://api.kde.org/frameworks/kinit/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.85/kinit-5.85.0.tar.xz"
  sha256 "92dfdfc00ba87edb41d228906ea0d5e7ab5381c639845082e1019342cf8ca60e"
  head "https://invent.kde.org/frameworks/kinit.git", branch: "master"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
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
    (testpath/"CMakeLists.txt").write("find_package(KF5Init REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
