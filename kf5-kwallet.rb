require "formula"

class Kf5Kwallet < Formula
  url "http://download.kde.org/stable/frameworks/5.9/kwallet-5.9.0.tar.xz"
  sha1 "b0b8edd94ab3f321e3c47199740a083472028aff"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kwallet.git'

  depends_on "libgcrypt"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"
  depends_on "haraldf/kf5/kf5-knotifications"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
