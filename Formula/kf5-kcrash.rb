require_relative "../lib/cmake"

class Kf5Kcrash < Formula
  desc "Support for application crash analysis and bug report from apps"
  homepage "https://api.kde.org/frameworks/kcrash/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.92/kcrash-5.92.0.tar.xz"
  sha256 "9bc5605b5026f55d9c2c1ca32c79842c3ad0f5c042e480fe1e7027b2692526c7"
  head "https://invent.kde.org/frameworks/kcrash.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kcoreaddons"
  depends_on "kde-mac/kde/kf5-kwindowsystem"

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Crash REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
