require "formula"

class Kf5Kitemmodels < Formula
  url "http://download.kde.org/stable/frameworks/5.25/kitemmodels-5.25.0.tar.xz"
  sha256 "e44a5c4ba997993057e8ebda6df400c3f1b97bf81d11bb02af27950ff1cd749d"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kitemmodels.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-dbus"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
