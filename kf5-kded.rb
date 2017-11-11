require "formula"

class Kf5Kded < Formula
  url "http://download.kde.org/stable/frameworks/5.40/kded-5.40.0.tar.xz"
  sha256 "0439d68e2b08a0084b6d15e92679692090271a873ee90dca8ed0a0afa1eac449"
  desc "Extensible deamon for providing system level services"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kded.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kinit"
  depends_on "qt"
  depends_on "gettext" => :build

  def install
    args = std_cmake_args

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
