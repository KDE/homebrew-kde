require_relative "../lib/cmake"

class Kcrash < Formula
  desc "Support for application crash analysis and bug report from apps"
  homepage "https://api.kde.org/frameworks/kcrash/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.7/kcrash-6.7.0.tar.xz"
  sha256 "1dc2c65d8ef62ef98457f8ab423b7686de3e713766c06e64d6322aa9db26eea4"
  head "https://invent.kde.org/frameworks/kcrash.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "qt@6"
  depends_on "kde-mac/kde/kcoreaddons"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF6Crash REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
