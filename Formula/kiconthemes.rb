require_relative "../lib/cmake"

class Kiconthemes < Formula
  desc "Support for icon themes"
  homepage "https://api.kde.org/frameworks/kiconthemes/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.7/kiconthemes-6.7.0.tar.xz"
  sha256 "be25bff1f5f65edd45b24ff9beda44b04c0e22d193e72458c96a5c591b70b968"
  head "https://invent.kde.org/frameworks/kiconthemes.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "gettext" => :build
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "karchive"
  depends_on "kde-mac/kde/kconfigwidgets"
  depends_on "kde-mac/kde/kitemviews"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF6IconThemes REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
