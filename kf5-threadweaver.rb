require "formula"

class Kf5Threadweaver < Formula
  url "http://download.kde.org/stable/frameworks/5.25/threadweaver-5.25.0.tar.xz"
  sha256 "7804df4d88c909cb6496d36cb2762e811454849d4a9092ac07b9096cbf5fe92e"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/threadweaver.git'

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
