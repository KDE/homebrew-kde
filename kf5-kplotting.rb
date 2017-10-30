require "formula"

class Kf5Kplotting < Formula
  desc "Lightweight plotting framework"
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.39/kplotting-5.39.0.tar.xz"
  sha256 "6ad90a3c774cec102dee21d63ba8b4d75b5bc95d61cf903480f11a3b840b3eb6"

  head "git://anongit.kde.org/kplotting.git"

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
