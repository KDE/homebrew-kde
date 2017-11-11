require "formula"

class Kf5Kjsembed < Formula
  url "http://download.kde.org/stable/frameworks/5.40/portingAids/kjsembed-5.40.0.tar.xz"
  sha256 "2dda7d9c5c19fa7450adf66ee8bd74365441d9e519ceca21a50557aa48218339"
  desc "Embedded JS"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/attica.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build
  depends_on "KDE-mac/kde/kf5-ki18n"
  depends_on "KDE-mac/kde/kf5-kjs"
  depends_on "qt"

  def install
    args = std_cmake_args
    args << "-DCMAKE_PREFIX_PATH=/usr/local/opt/gettext"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
