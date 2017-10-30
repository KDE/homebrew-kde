require "formula"

class Kf5Kitemviews < Formula
  desc "Widget addons for Qt Model/View"
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.39/kitemviews-5.39.0.tar.xz"
  sha256 "d069da87a28b373676b7bda1a1474c5f8c815441041cbc5af52d7c1a5a4a885e"

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
