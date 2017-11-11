require "formula"

class Kf5Kguiaddons < Formula
  url "http://download.kde.org/stable/frameworks/5.40/kguiaddons-5.40.0.tar.xz"
  sha256 "e1325bdbbed07ca73a6ee61129af31dd72c29aa7ab5a49bcfd015ea72eb1140a"
  desc "Addons to QtGui"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kguiaddons.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "qt"

  def install
    args = std_cmake_args

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
