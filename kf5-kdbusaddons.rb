require "formula"

class Kf5Kdbusaddons < Formula
  url "http://download.kde.org/stable/frameworks/5.5/kdbusaddons-5.5.0.tar.xz"
  sha1 "aeddb21cd70856e0ee72ea0496f7fa6bc5c015da"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kdbusaddons.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"
  depends_on "shared-mime-info"
  depends_on "d-bus"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
