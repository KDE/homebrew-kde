require "formula"

class Kf5Kdewebkit < Formula
  desc "KDE Integration for QtWebKit"
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.39/kdewebkit-5.39.0.tar.xz"
  sha256 "dd38c6d50681967cecb5debcbd1acc5135d465f15c46ceb7f2db32c4ffa0c015"

  head "git://anongit.kde.org/attica.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kparts"
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
