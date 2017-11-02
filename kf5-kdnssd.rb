require "formula"

class Kf5Kdnssd < Formula
  desc "Abstraction to system DNSSD features"
  homepage "http://www.kde.org/"
  url "https://download.kde.org/stable/frameworks/5.39/kdnssd-5.39.0.tar.xz"
  sha256 "e550cf9af93f9b22b49a812610cd31f286caf17cf44c82ed9b6d4290390f0db1"

  head "git://anongit.kde.org/attica.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
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
