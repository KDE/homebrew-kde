require "formula"

class Kf5Knewstuff < Formula
  url "http://download.kde.org/stable/frameworks/5.40/knewstuff-5.40.0.tar.xz"
  sha256 "71e00af7cfd4ead3dbd726c877c8f5c472af78881acd82e8155a1613fa5f9e44"
  desc "Support for downloading application assets from the network"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/knewstuff.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kio"
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
