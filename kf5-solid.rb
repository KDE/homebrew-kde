require "formula"

class Kf5Solid < Formula
  url "http://download.kde.org/stable/frameworks/5.37/solid-5.37.0.tar.xz"
  sha256 "14bd7b814f3fb87ea7d26338a05966380b1703d6679d44972a380415ae7d69bd"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/solid.git"

  depends_on "cmake" => :build
  # The bison 2.3 in Mac OS X is too old to build. Use homebrew's instead
  depends_on "bison" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
