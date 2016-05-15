require "formula"

class Kf5Solid < Formula
  url "http://download.kde.org/stable/frameworks/5.22/solid-5.22.0.tar.xz"
  sha256 "828f6444430eb8ced5cfd1d1d3886d0d25cd42e14671718a900b522f5ef94711"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/solid.git'

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
