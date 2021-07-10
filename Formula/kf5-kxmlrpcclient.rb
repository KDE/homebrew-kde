require_relative "../lib/cmake"

class Kf5Kxmlrpcclient < Formula
  desc "XML-RPC client library for KDE"
  homepage "https://api.kde.org/frameworks/kxmlrpcclient/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.84/portingAids/kxmlrpcclient-5.84.0.tar.xz"
  sha256 "d15ca2c58d3db2ff66cb3a26ee20a481de42e0efa6a5ba47278da734956f4d82"
  head "https://invent.kde.org/frameworks/kxmlrpcclient.git"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

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
