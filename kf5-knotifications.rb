require "formula"

class Kf5Knotifications < Formula
  url "http://download.kde.org/stable/frameworks/5.39/knotifications-5.39.0.tar.xz"
  sha256 "b21daed46b95f7d109c5c0e8d3d43e9f435ac497e33912420b495c9080626838"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/knotifications.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt"

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
