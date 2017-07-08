require "formula"

class Kf5Knotifications < Formula
  url "http://download.kde.org/stable/frameworks/5.36/knotifications-5.36.0.tar.xz"
  sha256 "e4004df99c6b470c0454e6c7a0e94ed540549ce6e6cc848f7c97b4e620a59ec2"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/knotifications.git"

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
