require_relative "../lib/cmake"

class Kf6Kidletime < Formula
  desc "Monitoring user activity"
  homepage "https://api.kde.org/frameworks/kidletime/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.5/kidletime-6.5.0.tar.xz"
  sha256 "b6dc7d6eadb642248000f165155a72d2dfab6c1a93e0130f8f83394a7628eaf6"
  head "https://invent.kde.org/frameworks/kidletime.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "qt@6"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF6IdleTime REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
