require_relative "../lib/cmake"

class Kf5Kdewebkit < Formula
  desc "KDE Integration for QtWebKit"
  homepage "https://api.kde.org/frameworks/kdewebkit/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.98/portingAids/kdewebkit-5.98.0.tar.xz"
  sha256 "c404acf67d89acc6aeff0f4f0c71724f662fc2397933810f27d2f500ffe37c0d"
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
