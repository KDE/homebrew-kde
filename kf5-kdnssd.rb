require "formula"

class Kf5Kdnssd < Formula
  url "http://download.kde.org/stable/frameworks/5.40/kdnssd-5.40.0.tar.xz"
  sha256 "d2b5194317e9db8ffa0180ac3af8da2bb6ed62411c147d7c255665a8394a8a82"
  desc "Abstraction to system DNSSD features"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/attica.git"

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
