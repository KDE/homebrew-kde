require "formula"

class Kf5Kwallet < Formula
  url "http://download.kde.org/stable/frameworks/5.36/kwallet-5.36.0.tar.xz"
  sha256 "8782caeb8d75da67a84c8eddf1d28af19fb01ffc0bbf7a35c0240e22519ccabb"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kwallet.git"

  depends_on "libgcrypt"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5"
  depends_on "haraldf/kf5/kf5-knotifications"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
