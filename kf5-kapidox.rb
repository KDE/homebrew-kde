require "formula"

class Kf5Kapidox < Formula
  desc "Frameworks API Documentation Tools"
  homepage "http://www.kde.org/"
  url "https://download.kde.org/stable/frameworks/5.39/kapidox-5.39.0.tar.xz"
  sha256 "d6701d35aa45b65dbf442d3325416c3100aa317a94fbeeb8f25595c782d2d58a"

  head "git://anongit.kde.org/kapidox.git"

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
