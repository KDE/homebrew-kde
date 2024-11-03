require_relative "../lib/cmake"

class Kcontacts < Formula
  desc "Support for vCard contacts"
  homepage "https://api.kde.org/frameworks/kcontacts/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.7/kcontacts-6.7.0.tar.xz"
  sha256 "292f8104f9f31d62c59289a3a821766d1ec540f4fc513ffc3b6f7197602d42c5"
  head "https://invent.kde.org/frameworks/kcontacts.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "gettext" => :build
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kcoreaddons"
  depends_on "kde-mac/kde/kconfig"
  depends_on "ki18n"
  depends_on "kde-mac/kde/kcodecs"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF6Contacts REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
