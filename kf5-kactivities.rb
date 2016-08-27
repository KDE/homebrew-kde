require "formula"

class Kf5Kactivities < Formula
  url "http://download.kde.org/stable/frameworks/5.25/kactivities-5.25.0.tar.xz"
  sha256 "17b57759181042165d8e774b8731857d6f5f8d2189bad8618412d6c95a2078ca"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kactivities.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-dbus"
  depends_on "haraldf/kf5/kf5-kconfig"
  depends_on "haraldf/kf5/kf5-kdeclarative"
  depends_on "haraldf/kf5/kf5-kdbusaddons"
  depends_on "haraldf/kf5/kf5-ki18n"
  depends_on "haraldf/kf5/kf5-kcmutils"
  depends_on "boost"

  def install
    args = std_cmake_args

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
