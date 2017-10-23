require "formula"

class Kf5Khtml < Formula
  desc "KHTML APIs"
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.39/portingAids/khtml-5.39.0.tar.xz"
  sha256 "a284c7c60bf0df22c4b92e9c341ca080cd49730c5218f572ed88a885365ff624"

  head "git://anongit.kde.org/khtml.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kdoctools" => :build
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
  depends_on "openssl"
  depends_on "qt"
  depends_on "jpeg"
  depends_on "giflib"
  depends_on "libpng"

  def install
    args = std_cmake_args

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end

