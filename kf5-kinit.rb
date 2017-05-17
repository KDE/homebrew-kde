require "formula"

class Kf5Kinit < Formula
  url "http://download.kde.org/stable/frameworks/5.34/kinit-5.34.0.tar.xz"
  sha256 "a10e2c454b7242792178a7f739eae3b46914a3ce237fcdc7b9515d18e54c8220"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kinit.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5"
  depends_on "haraldf/kf5/kf5-kio"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"

    mkdir_p "#{HOMEBREW_PREFIX}/lib/kde5/libexec"
    ln_sf "#{lib}/kde5/libexec/klauncher", "#{HOMEBREW_PREFIX}/lib/kde5/libexec/"

    prefix.install "install_manifest.txt"
  end
end
