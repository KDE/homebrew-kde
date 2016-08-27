require "formula"

class Kf5Kinit < Formula
  url "http://download.kde.org/stable/frameworks/5.25/kinit-5.25.0.tar.xz"
  sha256 "dda2b28923d06521d4f501f76e3b20e44ef9ace59b9285635d7d173ef975bcfd"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kinit.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-dbus"
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
