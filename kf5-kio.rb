require "formula"

class Kf5Kio < Formula
  url "http://download.kde.org/stable/frameworks/5.22/kio-5.22.0.tar.xz"
  sha256 "1ecf2fba135dc5403fbc843ade047f9b2586db6ce34e772a46abfaa417f5760a"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kio.git'

  option "without-kiowidgets", "Builds only KIO core"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-dbus"
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
