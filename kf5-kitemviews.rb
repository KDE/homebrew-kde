require "formula"

class Kf5Kitemviews < Formula
  url "http://download.kde.org/stable/frameworks/5.40/kitemviews-5.40.0.tar.xz"
  sha256 "a38ef5387bda4e50a4ca01a19632abf615c5823eb77df9c56f20eb6249b7870c"
  desc "Widget addons for Qt Model/View"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kitemviews.git"

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
