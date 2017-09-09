require "formula"

class Kf5Kdbusaddons < Formula
  url "http://download.kde.org/stable/frameworks/5.38/kdbusaddons-5.38.0.tar.xz"
  sha256 "1c1f8955570cd7e0480ec619084c5ea56cbffaca5307d9053d52092f10d589d7"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kdbusaddons.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt"
  depends_on "shared-mime-info"
  depends_on "d-bus"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
