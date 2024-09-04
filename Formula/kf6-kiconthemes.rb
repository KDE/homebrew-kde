require_relative "../lib/cmake"

class Kf6Kiconthemes < Formula
  desc "Support for icon themes"
  homepage "https://api.kde.org/frameworks/kiconthemes/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.5/kiconthemes-6.5.0.tar.xz"
  sha256 "cdc4c5788e0b3f88f25aa474d51d43496e4c742777f88025ef2fa606f2721331"
  head "https://invent.kde.org/frameworks/kiconthemes.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "gettext" => :build
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "karchive"
  depends_on "kde-mac/kde/kf6-kconfigwidgets"
  depends_on "kde-mac/kde/kf6-kitemviews"

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
