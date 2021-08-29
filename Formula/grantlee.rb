require_relative "../lib/cmake"

class Grantlee < Formula
  desc "String template engine based on the Django template system"
  homepage "https://github.com/steveire/grantlee"
  revision 1
  head "https://github.com/steveire/grantlee.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "lcov" => :build
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
    (testpath/"CMakeLists.txt").write("find_package(Grantlee5 REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
