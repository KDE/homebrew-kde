require "formula"

class Kf5Kunitconversion < Formula
  url "http://download.kde.org/unstable/frameworks/4.97.0/kunitconversion-4.97.0.tar.xz"
  sha1 "ea3b598812e735e0bcd5b91dd25e4e36b3659744"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kunitconversion.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"
  depends_on "haraldf/kf5/kf5-kjs"
  depends_on "haraldf/kf5/kf5-ki18n"
  depends_on "haraldf/kf5/kf5-kconfig"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
  end
end
