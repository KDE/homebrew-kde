require "formula"

class Kf5Kdelibs4support < Formula
  url "http://download.kde.org/stable/frameworks/5.34/portingAids/kdelibs4support-5.34.0.tar.xz"
  sha256 "2056de238cf237cbf0ddea3f882d2d696d4062175eb9ed89da83b0cda4963261"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kdelibs4support.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kded"
  depends_on "haraldf/kf5/kf5-kdoctools" => :build
  depends_on "qt5"
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
