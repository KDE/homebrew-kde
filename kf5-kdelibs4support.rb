require "formula"

class Kf5Kdelibs4support < Formula
  url "http://download.kde.org/stable/frameworks/5.25/portingAids/kdelibs4support-5.25.0.tar.xz"
  sha256 "6ca7bc090f32d6d43c4147815b3d13fae1de904088ff948a0fe8588d56093bb2"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kdelibs4support.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kded"
  depends_on "haraldf/kf5/kf5-kdoctools" => :build
  depends_on "qt5" => "with-dbus"
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
