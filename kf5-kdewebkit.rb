require "formula"

class Kf5Kdewebkit < Formula
  url "http://download.kde.org/stable/frameworks/5.40/kdewebkit-5.40.0.tar.xz"
  sha256 "eeb1451999ee83aa96b8ac8a77cb640c8bec837bf0b4ead3745645f4fcb0ecd8"
  desc "KDE Integration for QtWebKit"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/attica.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kparts"
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
