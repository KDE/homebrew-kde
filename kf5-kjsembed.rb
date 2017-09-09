require "formula"

class Kf5Kjsembed < Formula
  url "http://download.kde.org/stable/frameworks/5.38/portingAids/kjsembed-5.38.0.tar.xz"
  sha256 "0afdf41564f2f00e98c13cb160e9405ac40c11836dc0f354b50f01418a3d6059"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/attica.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kdoctools" => :build
  depends_on "haraldf/kf5/kf5-ki18n"
  depends_on "haraldf/kf5/kf5-kjs"
  depends_on "qt"

  def install
    args = std_cmake_args
    args << "-DCMAKE_PREFIX_PATH=/usr/local/opt/gettext"

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
