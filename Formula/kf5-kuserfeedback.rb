require_relative "../lib/cmake"

class Kf5Kuserfeedback < Formula
  desc "Framework for collecting user feedback for applications via telemetry and surveys"
  homepage "https://api.kde.org/frameworks/kuserfeedback/html/index.html"
  url "https://download.kde.org/stable/kuserfeedback/kuserfeedback-1.2.0.tar.xz"
  sha256 "76aac922b153249b274680a6f4c72c238ef14e3df04bad00cb64158b1063f264"
  head "https://invent.kde.org/libraries/kuserfeedback.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]

  depends_on "ninja" => :build
  depends_on "bison" => :build
  depends_on "doxygen" => :build

  depends_on "qt@5"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(UserFeedback REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
