require_relative "../lib/cmake"

class Kf5Kcrash < Formula
  desc "Support for application crash analysis and bug report from apps"
  homepage "https://api.kde.org/frameworks/kcrash/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.83/kcrash-5.83.0.tar.xz"
  sha256 "29ef0273ebd543be5bb9363efe5271fcaaea599463338d8ece625071decfa4c7"
  head "https://invent.kde.org/frameworks/kcrash.git"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

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
