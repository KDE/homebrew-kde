require "formula"

class Kf5Kcoreaddons < Formula
  url "http://download.kde.org/stable/frameworks/5.38/kcoreaddons-5.38.0.tar.xz"
  sha256 "9be3dd86402e173da025c0d326fd9a38ffeecb34828a287f8b8c530a5db275d4"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kcoreaddons.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt"
  depends_on "shared-mime-info"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
