require "formula"

class Kf5Kimageformats < Formula
  desc "Image format plugins for Qt5"
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.39/kimageformats-5.39.0.tar.xz"
  sha256 "a59082e8abbd141849e49762aac952f5f6d6820bf61cad0687bf618bbb6eced6"

  head "git://anongit.kde.org/kimageformats.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "qt"
  depends_on "openexr"
  depends_on "jasper"

  def install
    args = std_cmake_args

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
