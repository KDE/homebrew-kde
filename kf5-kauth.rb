require "formula"

class Kf5Kauth < Formula
  url "http://download.kde.org/stable/frameworks/5.34/kauth-5.34.0.tar.xz"
  sha256 "6da4cd885c1fcb474e3b4b46fb7a2ce39ee0a152a84a451f2fd0c673f50a9c19"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kauth.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5"
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
