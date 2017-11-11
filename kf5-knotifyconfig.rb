require "formula"

class Kf5Knotifyconfig < Formula
  url "http://download.kde.org/stable/frameworks/5.40/knotifyconfig-5.40.0.tar.xz"
  sha256 "73cc72e2f258e57f5c821a04ebdd36f6605688498d31dd523bd8e365719809b1"
  desc "Configuration system for KNotify"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/knotifyconfig.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kio"
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
