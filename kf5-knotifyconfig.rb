require "formula"

class Kf5Knotifyconfig < Formula
  desc "Configuration system for KNotify"
  homepage "http://www.kde.org/"
  url "https://download.kde.org/stable/frameworks/5.39/knotifyconfig-5.39.0.tar.xz"
  sha256 "2bf7d5c455a49e56d23a2295811060aa689223602a752269412a5d6db236d326"

  head "git://anongit.kde.org/knotifyconfig.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "qt"
  depends_on "KDE-mac/kde/kf5-kio"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
