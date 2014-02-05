require "formula"

class Kauth < Formula
  homepage "http://www.kde.org/"
  url "http://download.kde.org/unstable/frameworks/4.95.0/kauth-4.95.0.tar.xz"

  head 'git://anongit.kde.org/kauth.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/extra-cmake-modules" => :build
  depends_on "qt5"
  depends_on "haraldf/kf5/kcoreaddons"

  def install
    args = std_cmake_args
    args << "-DCMAKE_PREFIX_PATH=\"#{Formula.factory('qt5').opt_prefix};#{Formula.factory('extra-cmake-modules').opt_prefix}\""

    system "cmake", ".", *args
    system "make", "install"

    mkdir_p "#{HOMEBREW_PREFIX}/lib/kde5/libexec"
    ln_s "#{lib}/kde5/libexec/kauth-policy-gen.app", "#{HOMEBREW_PREFIX}/lib/kde5/libexec/"
  end
end
