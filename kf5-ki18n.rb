class Kf5Ki18n < Formula
  url "https://download.kde.org/stable/frameworks/5.40/ki18n-5.40.0.tar.xz"
  sha256 "a97a0d40a783dcefc7cd89903bb0a8f673b90c753f89c4e858960b07a24f68db"
  desc "Advanced internationalization framework"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/ki18n.git"

  depends_on "cmake" => :build
  depends_on "gettext" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "doxygen" => :build

  depends_on "qt"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"
    args << "-DCMAKE_SHARED_LINKER_FLAGS=-lintl" # cmake thinks libintl is part of libc
    args << "-DCMAKE_EXE_LINKER_FLAGS=-lintl"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
