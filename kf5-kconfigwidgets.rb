require "formula"

class Kf5Kconfigwidgets < Formula
  url "http://download.kde.org/stable/frameworks/5.40/kconfigwidgets-5.40.0.tar.xz"
  sha256 "7f5d1192238cba9170ccca0c9de12ae1a75176ec3de0b6e030cab451dda8bd3c"
  desc "Widgets for KConfig"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kconfigwidgets.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build
  depends_on "KDE-mac/kde/kf5-kauth"
  depends_on "KDE-mac/kde/kf5-kcoreaddons"
  depends_on "KDE-mac/kde/kf5-kcodecs"
  depends_on "KDE-mac/kde/kf5-kconfig"
  depends_on "KDE-mac/kde/kf5-kguiaddons"
  depends_on "KDE-mac/kde/kf5-kwidgetsaddons"
  depends_on "KDE-mac/kde/kf5-ki18n"
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
