require "formula"

class Kf5Kemoticons < Formula
  url "http://download.kde.org/stable/frameworks/5.5/kemoticons-5.5.0.tar.xz"
  sha1 "0ca29db7883103cd02d48eb858146c7effe41186"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kemoticons.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"

  depends_on "haraldf/kf5/kf5-karchive"
  depends_on "haraldf/kf5/kf5-kservice"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
