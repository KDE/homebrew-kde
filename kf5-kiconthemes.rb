require "formula"

class Kf5Kiconthemes < Formula
  url "http://download.kde.org/unstable/frameworks/4.98.0/kiconthemes-4.98.0.tar.xz"
  sha1 "3930625974723b7f72f61e24f92c3b5e89ef947c"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kiconthemes.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kauth"
  depends_on "haraldf/kf5/kf5-kconfigwidgets"
  depends_on "haraldf/kf5/kf5-kitemviews"
  depends_on "qt5" => "with-d-bus"

  def install
    args = std_cmake_args

    args << "-DCMAKE_CXX_FLAGS='-D_DARWIN_C_SOURCE'"

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
