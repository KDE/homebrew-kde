require_relative "../lib/cmake"

class Kf5Kitemmodels < Formula
  desc "Models for Qt Model/View system"
  homepage "https://api.kde.org/frameworks/kitemmodels/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.102/kitemmodels-5.102.0.tar.xz"
  sha256 "52f773f8969f07dd42c0f9afc5f9a604c8c450915228ada70b1058bae87938a6"
  head "https://invent.kde.org/frameworks/kitemmodels.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "qt@5"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5ItemModels REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
