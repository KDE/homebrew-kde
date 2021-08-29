require_relative "../lib/cmake"

class Kf5Kiconthemes < Formula
  desc "Support for icon themes"
  homepage "https://api.kde.org/frameworks/kiconthemes/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.85/kiconthemes-5.85.0.tar.xz"
  sha256 "97b592033ce8f46826824525c7c37915d3fb8b6bed32eb329aa18015ca88d64c"
  head "https://invent.kde.org/frameworks/kiconthemes.git", branch: "master"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "gettext" => :build
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "karchive"
  depends_on "kde-mac/kde/kf5-kconfigwidgets"
  depends_on "kde-mac/kde/kf5-kitemviews"

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5IconThemes REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
