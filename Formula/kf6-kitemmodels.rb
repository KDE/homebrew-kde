require_relative "../lib/cmake"

class Kf6Kitemmodels < Formula
  desc "Models for Qt Model/View system"
  homepage "https://api.kde.org/frameworks/kitemmodels/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.5/kitemmodels-6.5.0.tar.xz"
  sha256 "36ec04b3fd25249a1ce9cfd08824f2c2e40ef4d54224e118e06fa21c5f9a4f76"
  head "https://invent.kde.org/frameworks/kitemmodels.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "qt@6"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF6ItemModels REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
