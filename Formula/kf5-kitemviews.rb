require_relative "../lib/cmake"

class Kf5Kitemviews < Formula
  desc "Widget addons for Qt Model/View"
  homepage "https://api.kde.org/frameworks/kitemviews/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.86/kitemviews-5.86.0.tar.xz"
  sha256 "f6c261b76d9eebf665624691db664936d155cdf55ac70a7a2ad1f2ab360ff5d7"
  head "https://invent.kde.org/frameworks/kitemviews.git", branch: "master"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "qt@5"

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5ItemViews REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
