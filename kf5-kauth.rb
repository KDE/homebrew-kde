require "formula"

class Kf5Kauth < Formula
  url "http://download.kde.org/stable/frameworks/5.25/kauth-5.25.0.tar.xz"
  sha256 "1d62b32d88ba6c1e71e7b3ef67366710b9ce4488bcf82280fbe70d79b52f963a"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kauth.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-dbus"
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
