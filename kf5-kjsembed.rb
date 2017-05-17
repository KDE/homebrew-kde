require "formula"

class Kf5Kjsembed < Formula
  url "http://download.kde.org/stable/frameworks/5.34/portingAids/kjsembed-5.34.0.tar.xz"
  sha256 "73d57549e1f97672053fad9ee80db3909100e4f9f1b33ba40b7ae20bce88889f"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/attica.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kdoctools" => :build
  depends_on "haraldf/kf5/kf5-ki18n"
  depends_on "haraldf/kf5/kf5-kjs"
  depends_on "qt5"

  def install
    args = std_cmake_args
    args << "-DCMAKE_PREFIX_PATH=/usr/local/opt/gettext"

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
