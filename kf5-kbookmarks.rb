require "formula"

class Kf5Kbookmarks < Formula
  url "http://download.kde.org/stable/frameworks/5.40/kbookmarks-5.40.0.tar.xz"
  sha256 "5188516b868c2c4cc1820b127bc7660dda84e324c84222e07b94229358bc48c4"
  desc "Support for bookmarks and the XBEL format"
  homepage "http://www.kde.org/"

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
