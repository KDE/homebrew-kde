require_relative "../lib/cmake"

class Kf5Krunner < Formula
  desc "Process launcher to speed up launching KDE applications"
  homepage "https://api.kde.org/frameworks/krunner/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.79/krunner-5.79.0.tar.xz"
  sha256 "91a99cf7a5bd4eed6f272fa0d90a02312a9194660ccef80e67066465a252ee6c"
  head "https://invent.kde.org/frameworks/krunner.git"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "gettext" => :build
  depends_on "graphviz" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
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
