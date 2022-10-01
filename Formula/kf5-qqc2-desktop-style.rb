require_relative "../lib/cmake"

class Kf5Qqc2DesktopStyle < Formula
  desc "Style for Qt QC2 to follow your desktop theme"
  homepage "https://api.kde.org/frameworks/qqc2-desktop-style/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.98/qqc2-desktop-style-5.98.0.tar.xz"
  sha256 "edf4460e9431a7eb52c3595e2acea1fbc405387bdc06f7ec6f408849da8fc7a9"
  head "https://invent.kde.org/frameworks/qqc2-desktop-style.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kiconthemes"
  depends_on "kde-mac/kde/kf5-kirigami2"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5QQC2DeskopStyle REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
