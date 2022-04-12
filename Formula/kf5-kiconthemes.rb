require_relative "../lib/cmake"

class Kf5Kiconthemes < Formula
  desc "Support for icon themes"
  homepage "https://api.kde.org/frameworks/kiconthemes/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.93/kiconthemes-5.93.0.tar.xz"
  sha256 "75f7c5b34f4f1a228b4cbd81a284dbfdc0c0810ddd3a39e69f9363ab3598e2b4"
  head "https://invent.kde.org/frameworks/kiconthemes.git", branch: "master"

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
