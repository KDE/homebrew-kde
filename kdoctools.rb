require "formula"

class Kdoctools < Formula
  homepage "http://www.kde.org/"
  url "http://download.kde.org/unstable/frameworks/4.95.0/kdoctools-4.95.0.tar.xz"
  sha1 ""

  head 'git://anongit.kde.org/kdoctools.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/extra-cmake-modules" => :build
  depends_on "qt5"
  depends_on "docbook"
  depends_on "docbook-xsl"

  def install
    args = std_cmake_args
    args << "-DCMAKE_PREFIX_PATH=\"#{Formula.factory('qt5').opt_prefix};#{Formula.factory('extra-cmake-modules').opt_prefix};\""
    args << "-DDocBookXML_CURRENTDTD_DIR=\"#{Formula.factory('docbook').prefix}/docbook/xml/4.2\""
    args << "-DDocBookXSL_DIR=\"#{Formula.factory('docbook-xsl').prefix}/docbook-xsl\""

    system "cmake", ".", *args
    system "make", "install"
  end
end
