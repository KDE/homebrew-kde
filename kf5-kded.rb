require "formula"

class Kf5Kded < Formula
  desc "Extensible deamon for providing system level services"
  homepage "http://www.kde.org/"
  url "https://download.kde.org/stable/frameworks/5.39/kded-5.39.0.tar.xz"
  sha256 "453d349874b71a500afbb4a7c576be77bf38d3e87bd818269ccdfd27287c644b"

  head "git://anongit.kde.org/kded.git"

  depends_on "cmake" => :build
  depends_on "gettext" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build

  depends_on "qt"
  depends_on "KDE-mac/kde/kf5-kinit"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
