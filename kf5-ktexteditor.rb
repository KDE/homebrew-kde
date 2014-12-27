require "formula"

class Kf5Ktexteditor < Formula
  url "http://download.kde.org/stable/frameworks/5.5/ktexteditor-5.5.0.tar.xz"
  sha1 "9c5048c6d2ec9a1296b5c31a4b1c8a5c03447dbe"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/ktexteditor.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"
  depends_on "haraldf/kf5/kf5-kparts"

  def install
    args = std_cmake_args

    args << "-DCMAKE_CXX_FLAGS='-D_DARWIN_C_SOURCE'"

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
