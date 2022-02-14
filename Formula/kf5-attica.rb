require_relative "../lib/cmake"

class Kf5Attica < Formula
  desc "Open Collaboration Service client library"
  homepage "https://api.kde.org/frameworks/attica/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.92/attica-5.92.0.tar.xz"
  sha256 "bf647c7736acbbb99ff1557339f71b5efd5a7591b2af83b482d37d35516bc933"
  head "https://invent.kde.org/frameworks/attica.git", branch: "master"

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
    (testpath/"CMakeLists.txt").write("find_package(KF5Attica REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
