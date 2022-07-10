require_relative "../lib/cmake"

class Kf5Kcalendarcore < Formula
  desc "The KDE calendar access library"
  homepage "https://api.kde.org/frameworks/kcalendarcore/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.96/kcalendarcore-5.96.0.tar.xz"
  sha256 "b3e84dc29df6bc6e87ef5d44de4dad19a5eadebe25e8c4ed798f6c30908b3ea0"
  head "https://invent.kde.org/frameworks/kcalendarcore.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]

  depends_on "qt@5"
  depends_on "libical"

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5CalendarCore REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
