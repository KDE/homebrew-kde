require "formula"

class Kf5Phonon < Formula
  url "http://download.kde.org/stable/phonon/4.7.1/phonon-4.7.1.tar.xz"
  sha1 "f1d3214a752d97028dc4ed910a832c1272951522"
  head 'git://anongit.kde.org/phonon.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"

  def install
    args = std_cmake_args
    args << "-DPHONON_BUILD_PHONON4QT5=ON"

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
