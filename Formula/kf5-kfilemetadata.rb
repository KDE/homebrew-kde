class Kf5Kfilemetadata < Formula
  desc "Library for extracting file metadata"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.54/kfilemetadata-5.54.0.tar.xz"
  sha256 "4b6de53b791ad8cf19d5aa331555e3863f22e54adf6149668125635b820f86c2"

  head "git://anongit.kde.org/kfilemetadata.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "ebook-tools"
  depends_on "exiv2"
  depends_on "ffmpeg"
  depends_on "KDE-mac/kde/kf5-karchive"
  depends_on "KDE-mac/kde/kf5-ki18n"
  depends_on "poppler"
  depends_on "taglib"

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
