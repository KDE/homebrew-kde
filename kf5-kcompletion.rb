require "formula"

class Kf5Kcompletion < Formula
  url "http://download.kde.org/stable/frameworks/5.38/kcompletion-5.38.0.tar.xz"
  sha256 "5c943799729e7ed8d101eb2e11a09a2616d6c13c33d3575b2e61667e0c2f2539"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kcompletion.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kconfig"
  depends_on "haraldf/kf5/kf5-kwidgetsaddons"
  depends_on "qt"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
