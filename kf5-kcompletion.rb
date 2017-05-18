require "formula"

class Kf5Kcompletion < Formula
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.34/kcompletion-5.34.0.tar.xz"
  sha256 "9cddd50362b2f20273e4514b0c963182e65362964a82bec73270dab0ca6c1ba2"

  head "git://anongit.kde.org/kcompletion.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kconfig"
  depends_on "haraldf/kf5/kf5-kwidgetsaddons"
  depends_on "qt5"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
