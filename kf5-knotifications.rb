require "formula"

class Kf5Knotifications < Formula
  url "http://download.kde.org/stable/frameworks/5.25/knotifications-5.25.0.tar.xz"
  sha256 "b7810e42938331cd5f7f9f358362b3eb1221186c62762cd28860fdb66b6665bf"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/knotifications.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-dbus"

  depends_on "haraldf/kf5/kf5-kiconthemes"
  depends_on "haraldf/kf5/kf5-kservice"
  depends_on "haraldf/kf5/kf5-phonon"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
