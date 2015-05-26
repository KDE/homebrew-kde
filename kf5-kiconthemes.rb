require "formula"

class Kf5Kiconthemes < Formula
  url "http://download.kde.org/stable/frameworks/5.10/kiconthemes-5.10.0.tar.xz"
  sha1 "f630c0e8c71c62bb81d3d9a76c97fe553c5038c3"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kiconthemes.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
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
