require "formula"

class Kf5Knewstuff < Formula
  url "http://download.kde.org/stable/frameworks/5.25/knewstuff-5.25.0.tar.xz"
  sha256 "a1a3c5b096e24afd40284256449f797e1656663a91d175a2ad3cd4aa6bfd9ca8"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/knewstuff.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-dbus"

  depends_on "haraldf/kf5/kf5-kio"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
