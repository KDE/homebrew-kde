class KdevelopPgQt < Formula
  desc "LL(1) parser generator based on Qt"
  homepage "http://kdevelop.org"
  #url ""
  #sha256 ""

  head "git://anongit.kde.org/kdevelop-pg-qt.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
