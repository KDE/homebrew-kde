require "formula"

class Kf5Attica < Formula
  url "http://download.kde.org/stable/frameworks/5.40/attica-5.40.0.tar.xz"
  sha256 "3f1a907031a93cf505920482092ba5c362be639ccc9fb539f0365049a137e7d9"
  desc "Qt5 library that implements the Open Collaboration Services API"
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
