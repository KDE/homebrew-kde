require "formula"

class Kf5Kfilemetadata < Formula
  url "https://download.kde.org/stable/frameworks/5.40/kfilemetadata-5.40.0.tar.xz"
  sha256 "6b773fcda6977cf9c9c6e721343c90c66806691265fb1ada3498783158f33bfa"
  desc "A library for extracting file metadata"
  homepage "https://www.kde.org/"

  head "git://anongit.kde.org/kfilemetadata.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "qt"
  depends_on "ffmpeg"
  depends_on "taglib"
  depends_on "exiv2"
  depends_on "poppler" => "with-qt"
  depends_on "ebook-tools"
  depends_on "KDE-mac/kde/kf5-ki18n"
  depends_on "KDE-mac/kde/kf5-karchive"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
