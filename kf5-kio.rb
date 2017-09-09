require "formula"

class Kf5Kio < Formula
  url "http://download.kde.org/stable/frameworks/5.38/kio-5.38.0.tar.xz"
  sha256 "f43ab29c0ab51c78bd323e57fa6bba4aedf2d26d70df973b7ef7c80c9fc81597"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kio.git"

  option "without-kiowidgets", "Builds only KIO core"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt"
  depends_on "haraldf/kf5/kf5-karchive"
  depends_on "haraldf/kf5/kf5-kbookmarks" unless build.without? "kiowidgets"
  depends_on "haraldf/kf5/kf5-kjobwidgets" unless build.without? "kiowidgets"
  depends_on "haraldf/kf5/kf5-kwallet" unless build.without? "kiowidgets"
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
