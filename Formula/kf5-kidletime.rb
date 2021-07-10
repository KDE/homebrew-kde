require_relative "../lib/cmake"

class Kf5Kidletime < Formula
  desc "Monitoring user activity"
  homepage "https://api.kde.org/frameworks/kidletime/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.84/kidletime-5.84.0.tar.xz"
  sha256 "645fb3aa763f3c06091c359824b80c1dedc4012e0ea34ca7382ea55180fc732a"
  head "https://invent.kde.org/frameworks/kidletime.git"

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
    (testpath/"CMakeLists.txt").write("find_package(KF5IdleTime REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
