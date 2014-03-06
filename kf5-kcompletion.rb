require "formula"

class Kf5Kcompletion < Formula
  url "http://download.kde.org/unstable/frameworks/4.97.0/kcompletion-4.97.0.tar.xz"
  sha1 "93346ec824ac44f2d6aca014cb3d5d64099492ed"

  head 'git://anongit.kde.org/kcompletion.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kconfig"
  depends_on "haraldf/kf5/kf5-kwidgetsaddons"
  depends_on "qt5" => "with-d-bus"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
  end
end
