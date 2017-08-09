require "formula"

class Kf5Kmime < Formula
  homepage "http://kde.org/"
  head "git://anongit.kde.org/kmime.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-ki18n"
  depends_on "haraldf/kf5/kf5-kcodecs"
  depends_on "qt"

  def install
    args = std_cmake_args
    system "cmake", ".", *args
    system "make", "install"
  end
end
