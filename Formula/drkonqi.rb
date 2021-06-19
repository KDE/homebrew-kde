require_relative "../lib/cmake"

class Drkonqi < Formula
  desc "Crash handler for KDE software"
  homepage "https://kde.org/plasma-desktop/"
  url "https://download.kde.org/stable/plasma/5.22.1/drkonqi-5.22.1.tar.xz"
  sha256 "8af584eee19b984a6aa6dd2a795eb6b6ea0ebe1b03e69f8321a5f3c88ca7cf39"
  head "https://invent.kde.org/plasma/drkonqi.git"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

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
