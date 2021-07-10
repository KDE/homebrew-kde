require_relative "../lib/cmake"

class Kf5Kwindowsystem < Formula
  desc "Access to the windowing system"
  homepage "https://api.kde.org/frameworks/kwindowsystem/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.84/kwindowsystem-5.84.0.tar.xz"
  sha256 "cf81e7f318eab437d12e822f6e04331ec1c76d15df56bb792e4460758944caa5"
  head "https://invent.kde.org/frameworks/kwindowsystem.git"

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
    (testpath/"CMakeLists.txt").write("find_package(KF5WindowSystem REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
