require "formula"

class Kf5Kparts < Formula
  url "http://download.kde.org/stable/frameworks/5.30/kparts-5.30.0.tar.xz"
  sha256 "0f5d566f6c56e100b7a04f61c5287017dc4155c46fa6946337ad0c6c3df5f8e9"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kparts.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kio"

  depends_on "qt5"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
