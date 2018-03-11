class Kf5Kfilemetadata < Formula
  desc "Library for extracting file metadata"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.44/kfilemetadata-5.44.0.tar.xz"
  sha256 "6f9dd7ab57ff4465736272973a2f064fc68ff5dfbf7f56f8f4c7dcc7016d1d6d"

  head "git://anongit.kde.org/kfilemetadata.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "ebook-tools"
  depends_on "exiv2"
  depends_on "ffmpeg"
  depends_on "taglib"
  depends_on "poppler" => "with-qt"
  depends_on "KDE-mac/kde/kf5-karchive"
  depends_on "KDE-mac/kde/kf5-ki18n"

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
