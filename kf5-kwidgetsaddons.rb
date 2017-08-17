require "formula"

class Kf5Kwidgetsaddons < Formula
  url "http://download.kde.org/stable/frameworks/5.37/kwidgetsaddons-5.37.0.tar.xz"
  sha256 "a4c54b371a6fc748108f3e2ce2f40d422e8ef03210b243a3d091c090cf19b3ca"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kwidgetsaddons.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
