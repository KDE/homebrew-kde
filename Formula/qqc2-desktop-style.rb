require_relative "../lib/cmake"

class Qqc2DesktopStyle < Formula
  desc "Style for Qt QC2 to follow your desktop theme"
  homepage "https://api.kde.org/frameworks/qqc2-desktop-style/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.7/qqc2-desktop-style-6.7.0.tar.xz"
  sha256 "b6602d21ba891a63461827aa4513946aef0d8e0141f4a831aafb2c4d2e3fb329"
  head "https://invent.kde.org/frameworks/qqc2-desktop-style.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kiconthemes"
  depends_on "kde-mac/kde/kirigami"

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
