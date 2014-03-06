require "formula"

class Kf5Umbrella < Formula
  url "http://download.kde.org/unstable/frameworks/4.97.0/kf5umbrella-4.97.0.tar.xz"
  sha1 "3f530200d1808a86540fffd8695152cdedf93a63"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kf5umbrella.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
  end
end
