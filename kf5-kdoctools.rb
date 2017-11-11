require "formula"

class Kf5Kdoctools < Formula
  version "5.39.0"
  url "https://download.kde.org/stable/frameworks/#{version}/kdoctools-#{version}.tar.xz"
  sha256 "57a12705b87754d8bbc76e3400691d02072d61bd0e2e4b62845dca558f9be49d"
  desc "Documentation generation from docbook"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kdoctools.git"

  depends_on "cmake" => :build
  depends_on "perl" => :build
  depends_on "cpanminus" => :build
  depends_on "gettext" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-ki18n" => :build

  depends_on "qt"
  depends_on "docbook-xsl"
  depends_on "libxml2"
  depends_on "libxslt"
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

  def caveats; <<-EOS.undent
    Before install of this formula you need to run:
      cpanm URI
    EOS
  end
end
