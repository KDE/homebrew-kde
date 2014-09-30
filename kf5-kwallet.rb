require "formula"

class Kf5Kwallet < Formula
  url "http://download.kde.org/stable/frameworks/5.2.0/kwallet-5.2.0.tar.xz"
  sha1 "c07dec2ff0cac96187af618425fb32e324f320db"
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
