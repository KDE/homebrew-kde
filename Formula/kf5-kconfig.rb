require_relative "../lib/cmake"

class Kf5Kconfig < Formula
  desc "Persistent platform-independent application settings"
  homepage "https://api.kde.org/frameworks/kconfig/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.4/kconfig-6.4.0.tar.xz"
  sha256 "fbb3d06fde4ea19955cfdbcbcec03de78a46f8c228f41d4e7aa6ceb88dc116dd"
  head "https://invent.kde.org/frameworks/kconfig.git", branch: "master"

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
    (testpath/"CMakeLists.txt").write("find_package(KF5Config REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
