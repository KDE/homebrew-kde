require "formula"

class Kf5Kparts < Formula
  url "http://download.kde.org/stable/frameworks/5.40/kparts-5.40.0.tar.xz"
  sha256 "34cb664ca0235ee0ab996e544ee4e6afa6e945e723106610369ac5c7b17e75ef"
  desc "Document centric plugin system"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kparts.git"

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
