require_relative "../lib/cmake"

class Kf5Kwindowsystem < Formula
  desc "Access to the windowing system"
  homepage "https://api.kde.org/frameworks/kwindowsystem/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.93/kwindowsystem-5.93.0.tar.xz"
  sha256 "97cb223a4d1a7487a3ed496e10ff5e8c320ea7458eb34cbe4ed114bc19ebe4a1"
  head "https://invent.kde.org/frameworks/kwindowsystem.git", branch: "master"

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
    (testpath/"CMakeLists.txt").write("find_package(KF5WindowSystem REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
