require "formula"

class Kf5Kwindowsystem < Formula
  url "http://download.kde.org/stable/frameworks/5.40/kwindowsystem-5.40.0.tar.xz"
  sha256 "fff33531367425be18af75f10a8e40ff52f1383ecf97f37cf9c7c39baa308033"
  desc "Access to the windowing system"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kwindowsystem.git"

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
