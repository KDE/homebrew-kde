require "formula"

class Kf5Kdelibs4support < Formula
  url "http://download.kde.org/stable/frameworks/5.37/portingAids/kdelibs4support-5.37.0.tar.xz"
  sha256 "09d2a7817dbfd0aec82886fb2c5a83321d8b535a438013ed78d5611d2a00e1ff"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kdelibs4support.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kded"
  depends_on "haraldf/kf5/kf5-kdoctools" => :build
  depends_on "qt"
  depends_on "haraldf/kf5/kf5-kdesignerplugin"
  depends_on "haraldf/kf5/kf5-kemoticons"
  depends_on "haraldf/kf5/kf5-kinit"
  depends_on "haraldf/kf5/kf5-kitemmodels"
  depends_on "haraldf/kf5/kf5-kunitconversion"
  depends_on "haraldf/kf5/kf5-kparts"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
