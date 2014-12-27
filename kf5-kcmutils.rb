require "formula"

class Kf5Kcmutils < Formula
  url "http://download.kde.org/stable/frameworks/5.5/kcmutils-5.5.0.tar.xz"
  sha1 "2f08470ab71700cbc98e4b3090cc11f1a72452cc"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kcmutils.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"
  depends_on "haraldf/kf5/kf5-kxmlgui"

  def install
    args = std_cmake_args

    args << "-DCMAKE_CXX_FLAGS='-D_DARWIN_C_SOURCE'"

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
