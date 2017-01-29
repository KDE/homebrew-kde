require "formula"

class Kf5Knotifications < Formula
  url "http://download.kde.org/stable/frameworks/5.30/knotifications-5.30.0.tar.xz"
  sha256 "7a26925b16eb4c7df03589950c8b45e3b5656a620ace937e0f8cb71f5f8032a5"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/knotifications.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5"

  depends_on "haraldf/kf5/kf5-kiconthemes"
  depends_on "haraldf/kf5/kf5-kservice"
  depends_on "haraldf/kf5/kf5-phonon"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
