require_relative "../lib/cmake"

class Kf5Kunitconversion < Formula
  desc "Support for unit conversion"
  homepage "https://api.kde.org/frameworks/kunitconversion/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.115/kunitconversion-5.115.0.tar.xz"
  sha256 "9f89eb8b337af6dfe8150c6b83d9aa8d9b42e7cc9066af33b538e84aa0968e74"
  head "https://invent.kde.org/frameworks/kunitconversion.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "gettext" => :build
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "ki18n"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5UnitConversion REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
