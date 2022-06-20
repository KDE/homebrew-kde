require_relative "../lib/cmake"

class Kf5Kitemmodels < Formula
  desc "Models for Qt Model/View system"
  homepage "https://api.kde.org/frameworks/kitemmodels/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.95/kitemmodels-5.95.0.tar.xz"
  sha256 "75a131a0066efd87a06ee056eba7d03686227d53233154a70d7107a94e6b22d7"
  head "https://invent.kde.org/frameworks/kitemmodels.git", branch: "master"

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
