require_relative "../lib/cmake"

class Kf5Kguiaddons < Formula
  desc "Addons to QtGui"
  homepage "https://api.kde.org/frameworks/kguiaddons/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.111/kguiaddons-5.111.0.tar.xz"
  sha256 "f7deb0fd5f4ab6eb78b78357b95f0d93b8008253793315d94f5aa6688a0699c5"
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
