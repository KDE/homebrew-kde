require_relative "../lib/cmake"

class Kf5Krunner < Formula
  desc "Process launcher to speed up launching KDE applications"
  homepage "https://api.kde.org/frameworks/krunner/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.84/krunner-5.84.0.tar.xz"
  sha256 "37a8049e2161cfaa2659160fef0734c5a918a522ec40888fdca5c2b2530f5195"
  head "https://invent.kde.org/frameworks/krunner.git"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "gettext" => :build
  depends_on "graphviz" => :build
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-plasma-framework"
  depends_on "threadweaver"

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Runner REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
