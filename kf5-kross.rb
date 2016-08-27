require "formula"

class Kf5Kross < Formula
  url "http://download.kde.org/stable/frameworks/5.25/portingAids/kross-5.25.0.tar.xz"
  sha256 "84681930bbaa248e524651f95c3abce20a3b320c48a2df086675688974bb893f"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kross.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kdoctools" => :build
  depends_on "haraldf/kf5/kf5-kparts"
  depends_on "qt5" => "with-dbus"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
