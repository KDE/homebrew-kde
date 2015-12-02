require "formula"

class Kf5Alkimia < Formula
  homepage "http://kmymoney.org/"
  head "git://anongit.kde.org/alkimia.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"
  depends_on "gmp"
  
  depends_on "haraldf/kf5/kf5-kcoreaddons"
  
  def install
    args = std_cmake_args

    args << "-DCMAKE_CXX_FLAGS='-D_DARWIN_C_SOURCE'"

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end

__END__
