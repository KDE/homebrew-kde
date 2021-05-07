require_relative "../lib/cmake"

class Kf5Kitemmodels < Formula
  desc "Models for Qt Model/View system"
  homepage "https://api.kde.org/frameworks/kitemmodels/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.81/kitemmodels-5.81.0.tar.xz"
  sha256 "8093617c30c99d54562f6facdeb8929a7132841f13c63c4a0ad1a78e002e476f"
  head "https://invent.kde.org/frameworks/kitemmodels.git"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "qt@5"

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5ItemModels REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
