require "formula"

class Kf5Kio < Formula
  url "http://download.kde.org/stable/frameworks/5.5/kio-5.5.0.tar.xz"
  sha1 "1c8adb880927fb67041a9c3161f21547e2fbcb9f"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kio.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"
  depends_on "haraldf/kf5/kf5-karchive"
  depends_on "haraldf/kf5/kf5-kbookmarks"
  depends_on "haraldf/kf5/kf5-kjobwidgets"
  depends_on "haraldf/kf5/kf5-kwallet"
  depends_on "haraldf/kf5/kf5-solid"

  def install
    args = std_cmake_args
    args << "-DCMAKE_CXX_FLAGS='-D_DARWIN_C_SOURCE'"
    args << "-DCMAKE_C_FLAGS='-D_DARWIN_C_SOURCE'"
    args << "-DCMAKE_REQUIRED_DEFINITIONS='-D_DARWIN_C_SOURCE'"

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
