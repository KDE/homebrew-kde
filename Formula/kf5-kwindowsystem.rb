require_relative "../lib/cmake"

class Kf5Kwindowsystem < Formula
  desc "Access to the windowing system"
  homepage "https://api.kde.org/frameworks/kwindowsystem/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.100/kwindowsystem-5.100.0.tar.xz"
  sha256 "69b24ebaa5c94aa040c46dc1270a8fc9e44ed35d497c16b9b3244bb200834fb3"
  head "https://invent.kde.org/frameworks/kwindowsystem.git", branch: "master"

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
    (testpath/"CMakeLists.txt").write("find_package(KF5WindowSystem REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
