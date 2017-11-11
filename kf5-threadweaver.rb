require "formula"

class Kf5Threadweaver < Formula
  url "http://download.kde.org/stable/frameworks/5.40/threadweaver-5.40.0.tar.xz"
  sha256 "2f35c4b370c379fa10fbde3270e2576012f81cf357648706a3dd1a5bce65c346"
  desc "High-level multithreading framework"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/threadweaver.git"

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
