require "formula"

class Kf5Kcrash < Formula
  url "http://download.kde.org/stable/frameworks/5.37/kcrash-5.37.0.tar.xz"
  sha256 "c097aaca2c6ca8a177d697a8cccd4bd8bec2d09c07efd4bc7a4d0d3d1cbf629a"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kcrash.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt"

  depends_on "haraldf/kf5/kf5-kwindowsystem"
  depends_on "haraldf/kf5/kf5-kcoreaddons"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
