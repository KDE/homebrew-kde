require "formula"

class Kf5Kbookmarks < Formula
  desc "Support for bookmarks and the XBEL format"
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.39/kbookmarks-5.39.0.tar.xz"
  sha256 "e51b6e9551b649bbfadd95f40b0ae46e197a8bdaa051ccc10db17678985fcaf5"

  head "git://anongit.kde.org/kbookmarks.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kxmlgui"
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
