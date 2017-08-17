require "formula"

class Kf5Kwallet < Formula
  url "http://download.kde.org/stable/frameworks/5.37/kwallet-5.37.0.tar.xz"
  sha256 "5fc368410da498dcd9eb9d5b7119f37c87f3a6b9859bbb2ce4a2ff0cfca0f2d0"
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
