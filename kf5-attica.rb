require "formula"

class Kf5Attica < Formula
  url "http://download.kde.org/unstable/frameworks/4.97.0/attica-4.97.0.tar.xz"
  sha1 "7a0546152bc2dcb3e291519363edba81cd18c424"

  head 'git://anongit.kde.org/attica.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
  end
end
