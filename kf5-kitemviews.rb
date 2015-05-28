require "formula"

class Kf5Kitemviews < Formula
  url "http://download.kde.org/stable/frameworks/5.10/kitemviews-5.10.0.tar.xz"
  sha1 "8aa22f2edbfe475aee3fab2edf3af466784e187d"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kitemviews.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
