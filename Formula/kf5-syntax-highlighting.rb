require_relative "../lib/cmake"

class Kf5SyntaxHighlighting < Formula
  desc "Syntax highlighting engine for structured text and code"
  homepage "https://api.kde.org/frameworks/syntax-highlighting/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.111/syntax-highlighting-5.111.0.tar.xz"
  sha256 "c0a66ad2bf892792cf1f37ccc8df2607e2ad6753ae7e4023c7213c40f0425867"
  head "https://invent.kde.org/frameworks/syntax-highlighting.git", branch: "master"

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
    (testpath/"CMakeLists.txt").write("find_package(KF5SyntaxHighlighting REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
