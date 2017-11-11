require "formula"

class Kf5Kglobalaccel < Formula
  url "http://download.kde.org/stable/frameworks/5.40/kglobalaccel-5.40.0.tar.xz"
  sha256 "f66970fd45c6917840d5eb1d64b6732b4612fd27602144d587d00f4b979e54e3"
  desc "Add support for global workspace shortcuts"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kglobalaccel.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kconfig"
  depends_on "KDE-mac/kde/kf5-kcoreaddons"
  depends_on "KDE-mac/kde/kf5-kcrash"
  depends_on "KDE-mac/kde/kf5-kdbusaddons"
  depends_on "KDE-mac/kde/kf5-ki18n"
  depends_on "KDE-mac/kde/kf5-kservice"
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
