require "formula"

class Kf5Kpackage < Formula
  url "http://download.kde.org/stable/frameworks/5.40/kpackage-5.40.0.tar.xz"
  sha256 "b8ae58df3297402de06026f0fa38db9dce6a1e64c189d19959978d5c3a92109e"
  desc "Framework that lets applications manage user installable packages of non-binary assets"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kpackage.git"

  depends_on "cmake" => :build
  depends_on "gettext" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kcoreaddons"
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
