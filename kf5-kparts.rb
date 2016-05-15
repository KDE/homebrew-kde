require "formula"

class Kf5Kparts < Formula
  url "http://download.kde.org/stable/frameworks/5.22/kparts-5.22.0.tar.xz"
  sha256 "8f0d7188a990a59648328481e6d9917a3bd716a716b5e69cc6f761489da83c24"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kparts.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kio"

  depends_on "qt5" => "with-dbus"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
