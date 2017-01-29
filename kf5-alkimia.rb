require "formula"

class Kf5Alkimia < Formula
  homepage "http://kmymoney.org/"
  head "git://anongit.kde.org/alkimia.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5"
  depends_on "gmp"
  
  depends_on "haraldf/kf5/kf5-kcoreaddons"
  
  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end

__END__
