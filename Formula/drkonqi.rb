require_relative "../lib/cmake"

class Drkonqi < Formula
  desc "Crash handler for KDE software"
  homepage "https://kde.org/plasma-desktop/"
  url "https://download.kde.org/stable/plasma/5.23.2/drkonqi-5.23.2.tar.xz"
  sha256 "2eb515ffc6ceb5addcae6aafacaf245ed9b6416b2751a1ab5c9ad91b454f8f46"
  head "https://invent.kde.org/plasma/drkonqi.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kidletime"
  depends_on "kde-mac/kde/kf5-kxmlrpcclient"

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    assert_predicate lib/"drkonqi", :exist?
  end
end
