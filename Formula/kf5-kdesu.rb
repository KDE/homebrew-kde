require_relative "../lib/cmake"

class Kf5Kdesu < Formula
  desc "Integration with su for elevated privileges"
  homepage "https://api.kde.org/frameworks/kdesu/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.88/kdesu-5.88.0.tar.xz"
  sha256 "4505e560c6e5504a29f42baaa910b3efee401c4d8b7ed0fc1e2a6e2d776e25fd"
  head "https://invent.kde.org/frameworks/kdesu.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "gettext" => :build
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kpty"
  depends_on "kde-mac/kde/kf5-kservice"

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Su REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
