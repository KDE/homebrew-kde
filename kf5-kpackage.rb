require "formula"

class Kf5Kpackage < Formula
  url "http://download.kde.org/stable/frameworks/5.37/kpackage-5.37.0.tar.xz"
  sha256 "fac4d94dc33760aa71078f869fa0fc090c25a7aaf9547cc1a91bcd2b70296ec6"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kpackage.git"

  depends_on "cmake" => :build
  depends_on "gettext" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kcoreaddons"
  depends_on "qt"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
