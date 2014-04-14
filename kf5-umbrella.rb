require "formula"

class Kf5Umbrella < Formula
  url "http://download.kde.org/unstable/frameworks/4.98.0/kf5umbrella-4.98.0.tar.xz"
  sha1 "9cb4ecac62b7539b80ee95f89d70b4e50a565cef"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kf5umbrella.git'

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
