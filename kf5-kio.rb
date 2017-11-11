require "formula"

class Kf5Kio < Formula
  url "http://download.kde.org/stable/frameworks/5.40/kio-5.40.0.tar.xz"
  sha256 "30ea0b231b995faaf4283b9c9ecfaffb589268f5d7b5b805f69ed95601ac389b"
  desc "Resource and network access abstraction"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kio.git"

  option "without-kiowidgets", "Builds only KIO core"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-karchive"
  depends_on "KDE-mac/kde/kf5-kbookmarks" unless build.without? "kiowidgets"
  depends_on "KDE-mac/kde/kf5-kjobwidgets" unless build.without? "kiowidgets"
  depends_on "KDE-mac/kde/kf5-kwallet" unless build.without? "kiowidgets"
  depends_on "KDE-mac/kde/kf5-solid"
  depends_on "KDE-mac/kde/kf5-kservice"
  depends_on "qt"

  def install
    args = std_cmake_args
    args << "-DKIOCORE_ONLY=ON" if build.without? "kiowidgets"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
