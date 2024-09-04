require_relative "../lib/cmake"

class Kf6Kitemviews < Formula
  desc "Widget addons for Qt Model/View"
  homepage "https://api.kde.org/frameworks/kitemviews/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.5/kitemviews-6.5.0.tar.xz"
  sha256 "07f3b3880597995a9bbc3c9bc47dba2bcd924ec503b423ed8566e7e805cbb69c"
  head "https://invent.kde.org/frameworks/kitemviews.git", branch: "master"

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
    (testpath/"CMakeLists.txt").write("find_package(KF6ItemViews REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
