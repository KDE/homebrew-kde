require_relative "../lib/cmake"

class Kf5Kcompletion < Formula
  desc "Completion framework"
  homepage "https://api.kde.org/frameworks/kcompletion/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.82/kcompletion-5.82.0.tar.xz"
  sha256 "503646a0bf3f5e40daaea9b33618ffb39d0435d41cd736468d1806daefba247d"
  head "https://invent.kde.org/frameworks/kcompletion.git"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kconfig"
  depends_on "kde-mac/kde/kf5-kwidgetsaddons"

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Completion REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
