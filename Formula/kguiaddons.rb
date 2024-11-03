require_relative "../lib/cmake"

class Kguiaddons < Formula
  desc "Addons to QtGui"
  homepage "https://api.kde.org/frameworks/kguiaddons/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.7/kguiaddons-6.7.0.tar.xz"
  sha256 "ac437ca6baf50b0178bc8bf0b4dd1e6e70e0e4ef1ac770259738a1c42d035bcc"
  head "https://invent.kde.org/frameworks/kguiaddons.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "qt@6"

  def install
    system "cmake", "-DWITH_WAYLAND=OFF", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF6GuiAddons REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
