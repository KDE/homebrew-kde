require "formula"

class Kf5Kjsembed < Formula
  url "http://download.kde.org/stable/frameworks/5.25/portingAids/kjsembed-5.25.0.tar.xz"
  sha256 "d83f78bd15491d55f17d33f48c051cd3f6e37dcad382c7b460fb8132aadce1a9"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/attica.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kdoctools" => :build
  depends_on "haraldf/kf5/kf5-ki18n"
  depends_on "haraldf/kf5/kf5-kjs"
  depends_on "qt5" => "with-dbus"

  def install
    args = std_cmake_args
    args << "-DCMAKE_PREFIX_PATH=/usr/local/opt/gettext"

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
