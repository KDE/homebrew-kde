require "formula"

class Kf5Karchive < Formula
  url "http://download.kde.org/stable/frameworks/5.22/karchive-5.22.0.tar.xz"
  sha256 "2139df4664f32623949912a2a9ccdb966e77817e0494db6610925f69241a8dfb"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/karchive.git'

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
