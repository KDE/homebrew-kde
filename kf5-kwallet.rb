require "formula"

class Kf5Kwallet < Formula
  url "http://download.kde.org/stable/frameworks/5.4/kwallet-5.4.0.tar.xz"
  sha1 "6d0d867df58bf072749061a58c380c57975b6dd5"
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
