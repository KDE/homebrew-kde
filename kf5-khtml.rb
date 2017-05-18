require "formula"

class Kf5Khtml < Formula
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.34/portingAids/khtml-5.34.0.tar.xz"
  sha256 "bb5ba5a1a3896277f14d713b91bbbd53036e49289287100375eba26f9d048948"

  head "git://anongit.kde.org/khtml.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kdoctools" => :build
  depends_on "qt5"
  depends_on "jpeg"
  depends_on "giflib"
  depends_on "libpng"
  depends_on "haraldf/kf5/kf5-karchive"
  depends_on "haraldf/kf5/kf5-kcodecs"
  depends_on "haraldf/kf5/kf5-kglobalaccel"
  depends_on "haraldf/kf5/kf5-kiconthemes"
  depends_on "haraldf/kf5/kf5-ki18n"
  depends_on "haraldf/kf5/kf5-kio"
  depends_on "haraldf/kf5/kf5-kjs"
  depends_on "haraldf/kf5/kf5-knotifications"
  depends_on "haraldf/kf5/kf5-kparts"
  depends_on "haraldf/kf5/kf5-ktextwidgets"
  depends_on "haraldf/kf5/kf5-kwallet"
  depends_on "haraldf/kf5/kf5-kwidgetsaddons"
  depends_on "haraldf/kf5/kf5-sonnet"
  depends_on "haraldf/kf5/kf5-kxmlgui"

  def patches
    DATA
  end

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end

__END__
