require_relative "../lib/cmake"

class SyntaxHighlighting < Formula
  desc "Syntax highlighting engine for structured text and code"
  homepage "https://api.kde.org/frameworks/syntax-highlighting/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.7/syntax-highlighting-6.7.0.tar.xz"
  sha256 "6ef527a941740b9ddfe053eb08ead7e11c12a283aa88a5ddf1a18520cd9d2ca7"
  head "https://invent.kde.org/frameworks/syntax-highlighting.git", branch: "master"

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
    (testpath/"CMakeLists.txt").write("find_package(KF6SyntaxHighlighting REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
