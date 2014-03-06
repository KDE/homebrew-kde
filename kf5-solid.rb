require "formula"

class Kf5Solid < Formula
  url "http://download.kde.org/unstable/frameworks/4.97.0/solid-4.97.0.tar.xz"
  sha1 "11be40cbfc4b7247c29bd973cfde0354d6237ab4"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/solid.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
  end
end
