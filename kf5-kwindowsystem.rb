require "formula"

class Kf5Kwindowsystem < Formula
  desc "Access to the windowing system"
  homepage "http://www.kde.org/"
  url "https://download.kde.org/stable/frameworks/5.39/kwindowsystem-5.39.0.tar.xz"
  sha256 "17771aa0acf93b32329633aac9b07e72448edee2a2ecfe7a8f0040a23638dab7"

  head "git://anongit.kde.org/kwindowsystem.git"

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
