require "formula"

class Kf5Kitemviews < Formula
  url "http://download.kde.org/stable/frameworks/5.37/kitemviews-5.37.0.tar.xz"
  sha256 "55737ee6cf018c86e2674d417a0c234b060bb58b8eac477e862ec6e8a9dd279f"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kitemviews.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
