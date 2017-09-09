require "formula"

class Kf5Kemoticons < Formula
  url "http://download.kde.org/stable/frameworks/5.38/kemoticons-5.38.0.tar.xz"
  sha256 "a5b54d48822055e409f04fe4a85bb057798c0b0c815a5f7c6ca24bd47c4809b0"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kemoticons.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt"

  depends_on "haraldf/kf5/kf5-karchive"
  depends_on "haraldf/kf5/kf5-kservice"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
