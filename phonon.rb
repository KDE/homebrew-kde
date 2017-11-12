require "formula"

class Phonon < Formula
  desc "The multimedia framework for KF5"
  homepage "http://www.kde.org/"
  url "https://download.kde.org/stable/phonon/4.9.1/phonon-4.9.1.tar.xz"
  sha256 "67bee986f85ca8b575186c8ba58a85886cb3b1c3567c86a118d56129f221e69c"

  head "git://anongit.kde.org/phonon.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "qt"

  def install
    args = std_cmake_args
    args << "-DCMAKE_SKIP_RPATH=ON"
    args << "-DPHONON_BUILD_PHONON4QT5=ON"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
