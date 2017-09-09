require "formula"

class Kf5Kwallet < Formula
  url "http://download.kde.org/stable/frameworks/5.38/kwallet-5.38.0.tar.xz"
  sha256 "dc06fe8917cf5ea61251e42e9c7e9e5662eb223aace1bf8ee4becf6a896cdae3"
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
