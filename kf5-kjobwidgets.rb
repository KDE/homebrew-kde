require "formula"

class Kf5Kjobwidgets < Formula
  url "http://download.kde.org/stable/frameworks/5.3.0/kjobwidgets-5.3.0.tar.xz"
  sha1 "b4f3317fd4764b3ccc154274eeb0c434425e702b"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kjobwidgets.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kcoreaddons"
  depends_on "haraldf/kf5/kf5-kwidgetsaddons"
  depends_on "qt5" => "with-d-bus"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
