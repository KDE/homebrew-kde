require_relative "../lib/cmake"

class KdevelopPgQt < Formula
  desc "LL(1) parser generator based on Qt"
  homepage "https://kdevelop.org"
  url "https://download.kde.org/stable/kdevelop-pg-qt/2.2.1/src/kdevelop-pg-qt-2.2.1.tar.xz"
  sha256 "c13931788ac9dc02188cdd9c6e71e164ae81b4568b048748652bbf6fa4a9c62b"
  revision 1
  head "https://invent.kde.org/kdevelop/kdevelop-pg-qt.git"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
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
    (testpath/"CMakeLists.txt").write("find_package(KDevelop-PG-Qt REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
