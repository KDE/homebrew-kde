require "formula"

class Kf5Kitemmodels < Formula
  url "http://download.kde.org/stable/frameworks/5.40/kitemmodels-5.40.0.tar.xz"
  sha256 "a9bb04bde2b445fb23435619703aa38dd5ccb0f9fa2caaed1fe960061ec04546"
  desc "Models for Qt Model/View system"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kitemmodels.git"

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
