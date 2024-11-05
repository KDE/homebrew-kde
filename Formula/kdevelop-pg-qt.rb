require_relative "../lib/cmake"

class KdevelopPgQt < Formula
  desc "LL(1) parser generator based on Qt"
  homepage "https://kdevelop.org"
  url "https://download.kde.org/stable/kdevelop-pg-qt/2.3.0/src/kdevelop-pg-qt-2.3.0.tar.xz"
  sha256 "3d3ef3cb395e9670e60c399ea6d865cc796e00e52c355eed943fbeca7da7120d"
  head "https://invent.kde.org/kdevelop/kdevelop-pg-qt.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "qt@6"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KDevelop-PG-Qt REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
