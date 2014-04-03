require "formula"

class Kf5Kwindowsystem < Formula
  url "http://download.kde.org/unstable/frameworks/4.97.0/kwindowsystem-4.97.0.tar.xz"
  sha1 "81f41515ac9e55165e5538c5785bdc68fd9d390e"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kwindowsystem.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"

  def install
    args = std_cmake_args

    args << "-DCMAKE_CXX_FLAGS='-D_DARWIN_C_SOURCE -DQT_MAC_USE_COCOA'"

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
