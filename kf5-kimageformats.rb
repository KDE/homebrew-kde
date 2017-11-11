require "formula"

class Kf5Kimageformats < Formula
  url "http://download.kde.org/stable/frameworks/5.40/kimageformats-5.40.0.tar.xz"
  sha256 "a1d8546f628bca5eebcd255447e256c3f14cae090ad765f2e6ff19b1263ea4d1"
  desc "Image format plugins for Qt5"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kimageformats.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "qt"
  depends_on "openexr"
  depends_on "jasper"

  def install
    args = std_cmake_args

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
