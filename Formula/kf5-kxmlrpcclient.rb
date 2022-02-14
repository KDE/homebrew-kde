require_relative "../lib/cmake"

class Kf5Kxmlrpcclient < Formula
  desc "XML-RPC client library for KDE"
  homepage "https://api.kde.org/frameworks/kxmlrpcclient/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.92/portingAids/kxmlrpcclient-5.92.0.tar.xz"
  sha256 "0e32dca201f8b3d241e985c8dd8854774569d08167a9f3f060a141551e19beab"
  head "https://invent.kde.org/frameworks/kxmlrpcclient.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kio"

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5XmlRpcClient REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
