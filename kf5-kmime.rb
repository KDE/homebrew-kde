require "formula"

class Kf5Kmime < Formula
  desc "Library for handling mail messages and newsgroup articles"
  homepage "http://kde.org/"

  head "git://anongit.kde.org/kmime.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-ki18n"
  depends_on "KDE-mac/kde/kf5-kcodecs"
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
