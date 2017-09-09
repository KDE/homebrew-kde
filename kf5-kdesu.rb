require "formula"

class Kf5Kdesu < Formula
  url "http://download.kde.org/stable/frameworks/5.38/kdesu-5.38.0.tar.xz"
  sha256 "25b35914fa9cab6f70d09970324385d7ea14f3edb6ff1908bc12e403e31732b1"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kdesu.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kpty"
  depends_on "qt"
  depends_on "gettext" => :build

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
