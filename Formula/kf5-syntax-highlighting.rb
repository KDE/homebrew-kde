require_relative "../lib/cmake"

class Kf5SyntaxHighlighting < Formula
  desc "Syntax highlighting engine for structured text and code"
  homepage "https://api.kde.org/frameworks/syntax-highlighting/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.80/syntax-highlighting-5.80.0.tar.xz"
  sha256 "91f458918613703468512b00690a02b617eb47be4df5ed7d9e3f1311b3b31218"
  head "https://invent.kde.org/frameworks/syntax-highlighting.git"

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
    (testpath/"CMakeLists.txt").write("find_package(KF5SyntaxHighlighting REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
