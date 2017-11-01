require "formula"

class Kf5Kcodecs < Formula
  desc "Provide a collection of methods to manipulate strings using various encodings"
  homepage "http://www.kde.org/"
  url "https://download.kde.org/stable/frameworks/5.39/kcodecs-5.39.0.tar.xz"
  sha256 "eef017d861392296dcc54ff78361f732d9448e66ab977a69f1edf5e52c4214e0"

  head "git://anongit.kde.org/kcodecs.git"

  depends_on "cmake" => :build
  depends_on "gperf" => :build
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
