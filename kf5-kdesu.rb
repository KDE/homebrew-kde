require "formula"

class Kf5Kdesu < Formula
  url "http://download.kde.org/stable/frameworks/5.14/kdesu-5.14.0.tar.xz"
  sha1 "9057b5cb5171bd98eee4cb139a6bd2e800d305b3"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kdesu.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kpty"
  depends_on "qt5" => "with-d-bus"
  depends_on "gettext" => :build

  def install
    args = std_cmake_args
    args << "-DCMAKE_CXX_FLAGS='-D_DARWIN_C_SOURCE'"

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
