require_relative "../lib/cmake"

class Kf5Attica < Formula
  desc "Open Collaboration Service client library"
  homepage "https://api.kde.org/frameworks/attica/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.100/attica-5.100.0.tar.xz"
  sha256 "ae77669637f2c1c09666a5885d99ec7feaeeb51811dc61864556be6cf43d35c8"
  head "https://invent.kde.org/frameworks/attica.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "qt@5"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Attica REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
