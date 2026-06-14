require_relative "../lib/cmake"

class Kf5Kdewebkit < Formula
  desc "KDE Integration for QtWebKit"
  homepage "https://api.kde.org/frameworks/kdewebkit/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.116/portingAids/kdewebkit-5.116.0.tar.xz"
  sha256 "9d85ba25c159f15dc0e794366bcf5d2f401b6313004ee621409f35bb664ae368"
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
