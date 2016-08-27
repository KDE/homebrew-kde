require "formula"

class Kf5Kitemviews < Formula
  url "http://download.kde.org/stable/frameworks/5.25/kitemviews-5.25.0.tar.xz"
  sha256 "98078899862514cc16ceff0275fe5eab43bc14e8f361af11a8e3c45a2fc5a284"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kitemviews.git'

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
