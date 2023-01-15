require_relative "../lib/cmake"

class Kf5Kjsembed < Formula
  desc "Embedded JS"
  homepage "https://api.kde.org/frameworks/kjsembed/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.102/portingAids/kjsembed-5.102.0.tar.xz"
  sha256 "ba28f907eb3b69e98caf5877883f81051420e664819714fba2696c6093c92f9d"
  head "https://invent.kde.org/frameworks/kjsembed.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "gettext" => :build
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kjs"
  depends_on "ki18n"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5JsEmbed REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
