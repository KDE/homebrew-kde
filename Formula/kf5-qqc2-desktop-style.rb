class Kf5Qqc2DesktopStyle < Formula
  desc "Style for Qt Quick Controls 2 to make it follow your desktop theme"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.44/qqc2-desktop-style-5.44.0.tar.xz"
  sha256 "193445718d707e1b1bbe92e528fb1f6b399564777eb2aaeeb1000399a5f05ad6"
  revision 1

  head "git://anongit.kde.org/qqc2-desktop-style.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "qt"
  depends_on "KDE-mac/kde/kf5-kirigami2" => :build
  depends_on "KDE-mac/kde/kf5-kiconthemes" => :build
  depends_on "KDE-mac/kde/kf5-kconfigwidgets" => :build

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
