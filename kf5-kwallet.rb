require "formula"

class Kf5Kwallet < Formula
  url "http://download.kde.org/stable/frameworks/5.39/kwallet-5.39.0.tar.xz"
  sha256 "5f83a5ca245773abfe5b31c536996ca1aee312d512181d133edcd890874f9fee"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kwallet.git"

  depends_on "libgcrypt"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt"
  depends_on "haraldf/kf5/kf5-knotifications"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
