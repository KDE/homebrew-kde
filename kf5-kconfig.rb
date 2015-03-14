require "formula"

class Kf5Kconfig < Formula
  url "http://download.kde.org/stable/frameworks/5.8/kconfig-5.8.0.tar.xz"
  sha1 "f1e78e1b29a6d255c5cb67172c8c23ac585b6df3"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kconfig.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"

    mkdir_p "#{HOMEBREW_PREFIX}/lib/kde5/libexec"
    ln_sf "#{lib}/kde5/libexec/kconf_update.app", "#{HOMEBREW_PREFIX}/lib/kde5/libexec/"
  end
end
