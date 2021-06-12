require_relative "../lib/cmake"

class Kf5Kcmutils < Formula
  desc "Utilities for KDE System Settings modules"
  homepage "https://api.kde.org/frameworks/kcmutils/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.83/kcmutils-5.83.0.tar.xz"
  sha256 "4ee1e549a5ad28cc75efd396d86326efff16da485cb74d1daeb2a65e03780665"
  head "https://invent.kde.org/frameworks/kcmutils.git"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kdeclarative"

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  def caveats
    <<~EOS
      You need to take some manual steps in order to make this formula work:
        "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
    EOS
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5KCMUtils REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
