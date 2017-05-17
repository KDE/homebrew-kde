require "formula"

class Kf5Kross < Formula
  url "http://download.kde.org/stable/frameworks/5.34/portingAids/kross-5.34.0.tar.xz"
  sha256 "b82fb3da9837c46dcdb71de0656189e543972bb29b93b95dda54c5e837fa5824"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kross.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kdoctools" => :build
  depends_on "haraldf/kf5/kf5-kparts"
  depends_on "qt5"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
