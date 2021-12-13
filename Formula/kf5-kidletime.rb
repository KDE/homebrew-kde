require_relative "../lib/cmake"

class Kf5Kidletime < Formula
  desc "Monitoring user activity"
  homepage "https://api.kde.org/frameworks/kidletime/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.89/kidletime-5.89.0.tar.xz"
  sha256 "dfe1bffde505d0266ef7e37220f7026f7128291a360e3cd7f0d426eb91f48714"
  head "https://invent.kde.org/frameworks/kidletime.git", branch: "master"

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
    (testpath/"CMakeLists.txt").write("find_package(KF5IdleTime REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
