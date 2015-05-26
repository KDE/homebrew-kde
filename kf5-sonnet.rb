require "formula"

class Kf5Sonnet < Formula
  url "http://download.kde.org/stable/frameworks/5.10/sonnet-5.10.0.tar.xz"
  sha1 "47257344bb02f6a5035322d6078b07246255ac05"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/sonnet.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
