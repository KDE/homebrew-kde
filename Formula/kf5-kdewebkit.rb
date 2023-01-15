require_relative "../lib/cmake"

class Kf5Kdewebkit < Formula
  desc "KDE Integration for QtWebKit"
  homepage "https://api.kde.org/frameworks/kdewebkit/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.102/portingAids/kdewebkit-5.102.0.tar.xz"
  sha256 "7bce0e7dcc1394e149b727c4a6aeb9ba5a02532f2ff4f0502bd7d5a64e42f28c"
  head "https://invent.kde.org/frameworks/kdewebkit.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kparts"
  depends_on "kde-mac/kde/qt-webkit"

  def install
    system "cmake",
           "-DQt5WebKitWidgets_DIR=#{Formula["qt-webkit"].opt_prefix}/lib/cmake/Qt5WebKitWidgets",
           *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5WebKit REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
