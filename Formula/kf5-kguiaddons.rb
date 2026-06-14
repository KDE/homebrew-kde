require_relative "../lib/cmake"

class Kf5Kguiaddons < Formula
  desc "Addons to QtGui"
  homepage "https://api.kde.org/frameworks/kguiaddons/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.116/kguiaddons-5.116.0.tar.xz"
  sha256 "5c10d56cb02cb60710c2412d4a3d02671cad74f25d1e9889c6c741f6e833fce6"
  head "https://invent.kde.org/frameworks/kguiaddons.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "qt@5"

  def install
    system "cmake", "-DWITH_WAYLAND=OFF", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5GuiAddons REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
