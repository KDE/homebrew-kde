require "formula"

class Kf5Knotifications < Formula
  url "http://download.kde.org/unstable/frameworks/4.97.0/knotifications-4.97.0.tar.xz"
  sha1 "7e735e4f75cf72e57e452d912d7ed03c44fccda3"

  head 'git://anongit.kde.org/knotifications.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"

  depends_on "haraldf/kf5/kf5-kwindowsystem"
  depends_on "haraldf/kf5/kf5-kiconthemes"
  depends_on "haraldf/kf5/kf5-phonon"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
