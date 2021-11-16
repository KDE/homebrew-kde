require_relative "../lib/cmake"

class Kf5Kplotting < Formula
  desc "Lightweight plotting framework"
  homepage "https://api.kde.org/frameworks/kplotting/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.88/kplotting-5.88.0.tar.xz"
  sha256 "b7b5438bfcf113e13977861644e29871552ec337a100b99d9eba9e5cf6a42a41"
  head "https://invent.kde.org/frameworks/kplotting.git", branch: "master"

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
    (testpath/"CMakeLists.txt").write("find_package(KF5Plotting REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
