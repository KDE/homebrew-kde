require_relative "../lib/cmake"

class Kf5Kplotting < Formula
  desc "Lightweight plotting framework"
  homepage "https://api.kde.org/frameworks/kplotting/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.115/kplotting-5.115.0.tar.xz"
  sha256 "836e5c74a9c4c812e4fce2399cc2c29cb61c7810e7d3f4f992d051e1c5f0e1f3"
  head "https://invent.kde.org/frameworks/kplotting.git", branch: "master"

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
    (testpath/"CMakeLists.txt").write("find_package(KF5Plotting REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
