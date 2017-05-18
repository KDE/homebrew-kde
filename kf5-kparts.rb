require "formula"

class Kf5Kparts < Formula
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.34/kparts-5.34.0.tar.xz"
  sha256 "e73eaa30bec4a4a5223855dd5493c5b27bbaee5efcbfb74d5d8235498f03b6a8"

  head "git://anongit.kde.org/kparts.git"

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
