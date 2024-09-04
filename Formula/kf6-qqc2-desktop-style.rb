require_relative "../lib/cmake"

class Kf6Qqc2DesktopStyle < Formula
  desc "Style for Qt QC2 to follow your desktop theme"
  homepage "https://api.kde.org/frameworks/qqc2-desktop-style/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.5/qqc2-desktop-style-6.5.0.tar.xz"
  sha256 "888638775a4c8bb7f80e10e878fd923880c75f2aa6e3878d52c12a77f3da9321"
  head "https://invent.kde.org/frameworks/qqc2-desktop-style.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf6-kiconthemes"
  depends_on "kde-mac/kde/kf6-kirigami"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF6QQC2DeskopStyle REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
