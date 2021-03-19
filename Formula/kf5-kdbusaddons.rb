require_relative "../lib/cmake"

class Kf5Kdbusaddons < Formula
  desc "Addons to QtDBus"
  homepage "https://api.kde.org/frameworks/kdbusaddons/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.79/kdbusaddons-5.79.0.tar.xz"
  sha256 "2071c5a06226b77c4cb1d4e46b50258c980e57448fdbb1a49259db64a7a2539f"
  head "https://invent.kde.org/frameworks/kdbusaddons.git"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "dbus"
  depends_on "qt@5"

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5DBusAddons REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
