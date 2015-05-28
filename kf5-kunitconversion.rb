require "formula"

class Kf5Kunitconversion < Formula
  url "http://download.kde.org/stable/frameworks/5.10/kunitconversion-5.10.0.tar.xz"
  sha1 "1a7c7222b502f20f25b5b437f9ec1fd2e8964ba5"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kunitconversion.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"
  depends_on "gettext" => :build
  depends_on "haraldf/kf5/kf5-ki18n"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
