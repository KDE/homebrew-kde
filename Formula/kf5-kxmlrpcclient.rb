require_relative "../lib/cmake"

class Kf5Kxmlrpcclient < Formula
  desc "XML-RPC client library for KDE"
  homepage "https://api.kde.org/frameworks/kxmlrpcclient/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.100/portingAids/kxmlrpcclient-5.100.0.tar.xz"
  sha256 "b946ffebb297777fe0fda19b00e4f2bc3a8624ab4cb301bd5c818b83d49cce3a"
  head "https://invent.kde.org/frameworks/kxmlrpcclient.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kio"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5XmlRpcClient REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
