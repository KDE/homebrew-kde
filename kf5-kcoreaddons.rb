require "formula"

class Kf5Kcoreaddons < Formula
  desc "Addons to QtCore"
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.39/kcoreaddons-5.39.0.tar.xz"
  sha256 "9f6e76c2a15252d2974271e4e3734a64aec157a434251c23b27efaa809d95363"

  head "git://anongit.kde.org/kcoreaddons.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "qt"
  depends_on "shared-mime-info"

  def install
    args = std_cmake_args

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
