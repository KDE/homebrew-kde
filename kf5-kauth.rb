require "formula"

class Kf5Kauth < Formula
  url "http://download.kde.org/stable/frameworks/5.3.0/kauth-5.3.0.tar.xz"
  sha1 "355fa2571b7abf16617148393279602059084df5"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kauth.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"
  depends_on "haraldf/kf5/kf5-kcoreaddons"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"

    mkdir_p "#{HOMEBREW_PREFIX}/lib/kde5/libexec"
    ln_sf "#{lib}/kde5/libexec/kauth-policy-gen.app", "#{HOMEBREW_PREFIX}/lib/kde5/libexec/"
  end
end
