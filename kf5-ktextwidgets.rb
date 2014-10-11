require "formula"

class Kf5Ktextwidgets < Formula
  url "http://download.kde.org/stable/frameworks/5.3.0/ktextwidgets-5.3.0.tar.xz"
  sha1 "4c0c3bb911813b57e5a20a782f377789464a12ea"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/ktextwidgets.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kcompletion"
  depends_on "haraldf/kf5/kf5-kiconthemes"
  depends_on "haraldf/kf5/kf5-kservice"
  depends_on "haraldf/kf5/kf5-sonnet"
  depends_on "qt5" => "with-d-bus"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
