require_relative "../lib/cmake"

class Kf5Kidletime < Formula
  desc "Monitoring user activity"
  homepage "https://api.kde.org/frameworks/kidletime/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.86/kidletime-5.86.0.tar.xz"
  sha256 "5b5f3436f7639d86f7b8cafc50771d3933c3fe972bb15ab0f8ec0f97200bb383"
  head "https://invent.kde.org/frameworks/kidletime.git", branch: "master"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

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
    (testpath/"CMakeLists.txt").write("find_package(KF5IdleTime REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
