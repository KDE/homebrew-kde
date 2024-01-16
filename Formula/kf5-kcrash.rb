require_relative "../lib/cmake"

class Kf5Kcrash < Formula
  desc "Support for application crash analysis and bug report from apps"
  homepage "https://api.kde.org/frameworks/kcrash/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.115/kcrash-5.115.0.tar.xz"
  sha256 "b2eaf5bc6351faf6531dbfd6535a414f13a80e002b44f325c4516eeaea6e03ad"
  head "https://invent.kde.org/frameworks/kcrash.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kcoreaddons"
  depends_on "kde-mac/kde/kf5-kwindowsystem"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Crash REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
