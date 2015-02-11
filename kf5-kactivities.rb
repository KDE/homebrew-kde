require "formula"

class Kf5Kactivities < Formula
  url "http://download.kde.org/stable/frameworks/5.6/kactivities-5.6.0.tar.xz"
  sha1 "7d3b39072feb65d5ec27699e6ffe34ed05b8f0e7"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kactivities.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"
  depends_on "haraldf/kf5/kf5-kdeclarative"
  depends_on "haraldf/kf5/kf5-kdbusaddons"
  depends_on "haraldf/kf5/kf5-ki18n"
  depends_on "haraldf/kf5/kf5-kcmutils"
  depends_on "boost"

  def install
    args = std_cmake_args
    args << "-DCMAKE_CXX_FLAGS='-D_DARWIN_C_SOURCE'"
    args << "-DCMAKE_C_FLAGS='-D_DARWIN_C_SOURCE'"
    args << "-DCMAKE_REQUIRED_DEFINITIONS='-D_DARWIN_C_SOURCE'"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
