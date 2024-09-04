require_relative "../lib/cmake"

class Kf6Kjobwidgets < Formula
  desc "Widgets for tracking KJob instances"
  homepage "https://api.kde.org/frameworks/kjobwidgets/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.5/kjobwidgets-6.5.0.tar.xz"
  sha256 "67c5dab1191ae6830d452751767e94991b34feaf4228f18ab042c2c120910ad8"
  head "https://invent.kde.org/frameworks/kjobwidgets.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf6-kcoreaddons"
  depends_on "kde-mac/kde/kf6-kwidgetsaddons"
  depends_on "kde-mac/kde/kf6-knotifications"
  depends_on "qt@6"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF6JobWidgets REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
