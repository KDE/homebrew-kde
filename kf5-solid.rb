require "formula"

class Kf5Solid < Formula
  url "http://download.kde.org/stable/frameworks/5.40/solid-5.40.0.tar.xz"
  sha256 "1dc96f12c3bbade6ab71794915ed7968b7ed8acc6b7a8cec5ad9c3708ece42ce"
  desc "Hardware integration and detection"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/solid.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  # The bison 2.3 in Mac OS X is too old to build. Use homebrew's instead
  depends_on "bison" => :build
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
