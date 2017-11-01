require "formula"

class Kf5Attica < Formula
  desc "Qt5 library that implements the Open Collaboration Services API"
  homepage "http://www.kde.org/"
  url "https://download.kde.org/stable/frameworks/5.39/attica-5.39.0.tar.xz"
  sha256 "4ec1527e54e029c88135b5ed4851874ebb19a566b3c690c62ce6118b42112795"

  head "git://anongit.kde.org/attica.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "qt"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
