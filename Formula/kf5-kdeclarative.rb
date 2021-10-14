require_relative "../lib/cmake"

class Kf5Kdeclarative < Formula
  desc "Provides integration of QML and KDE Frameworks"
  homepage "https://api.kde.org/frameworks/kdeclarative/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.87/kdeclarative-5.87.0.tar.xz"
  sha256 "6792f8ee5e255159d302ba8257b91e52a4ac5815fb7413fd73788f893555a47f"
  head "https://invent.kde.org/frameworks/kdeclarative.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kio"
  depends_on "kde-mac/kde/kf5-kpackage"
  depends_on "libepoxy"

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Declarative REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
