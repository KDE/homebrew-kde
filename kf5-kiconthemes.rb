require "formula"

class Kf5Kiconthemes < Formula
  url "http://download.kde.org/stable/frameworks/5.38/kiconthemes-5.38.0.tar.xz"
  sha256 "2a7dc525c1e9eea8c8952ca4eeccc22c28bb37ea83895fd7166174263218aa07"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kiconthemes.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kconfigwidgets"
  depends_on "haraldf/kf5/kf5-kitemviews"
  depends_on "qt"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
