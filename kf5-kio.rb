require "formula"

class Kf5Kio < Formula
  url "http://download.kde.org/stable/frameworks/5.30/kio-5.30.0.tar.xz"
  sha256 "a15a688395e7c8a22e78b0cf5a8b9c3c4bd679bf667b23f50ae82b36cf5e363a"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kio.git'

  option "without-kiowidgets", "Builds only KIO core"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5"
  depends_on "haraldf/kf5/kf5-karchive"
  depends_on "haraldf/kf5/kf5-kbookmarks" if not build.without? "kiowidgets"
  depends_on "haraldf/kf5/kf5-kjobwidgets" if not build.without? "kiowidgets"
  depends_on "haraldf/kf5/kf5-kwallet" if not build.without? "kiowidgets"
  depends_on "haraldf/kf5/kf5-solid"
  depends_on "haraldf/kf5/kf5-kservice"

  def install
    args = std_cmake_args
    args << "-DKIOCORE_ONLY=ON" if build.without? "kiowidgets"

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
