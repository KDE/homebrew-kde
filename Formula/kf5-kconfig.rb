require_relative "../lib/cmake"

class Kf5Kconfig < Formula
  desc "Persistent platform-independent application settings"
  homepage "https://api.kde.org/frameworks/kconfig/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.92/kconfig-5.92.0.tar.xz"
  sha256 "7801b641b88368a0c021272073c692337b42ee28f0025d106942c8ce873b0523"
  head "https://invent.kde.org/frameworks/kconfig.git", branch: "master"

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
    (testpath/"CMakeLists.txt").write("find_package(KF5Config REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
