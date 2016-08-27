require "formula"

class Kf5Kplotting < Formula
  url "http://download.kde.org/stable/frameworks/5.25/kplotting-5.25.0.tar.xz"
  sha256 "4a960a0bbeb364702dfecd4cff61c4082bc7a04736ed76d4deef821f7b246676"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kplotting.git'

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
