require "formula"

class Kf5Knotifyconfig < Formula
  url "http://download.kde.org/stable/frameworks/5.38/knotifyconfig-5.38.0.tar.xz"
  sha256 "d333e83fb372b93493092084418af9fa5557e017c30c923bbd6a5d6f2a7d0f16"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/knotifyconfig.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt"
  depends_on "haraldf/kf5/kf5-kio"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
