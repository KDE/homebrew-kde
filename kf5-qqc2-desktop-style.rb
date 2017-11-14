class Kf5Qqc2DesktopStyle < Formula
  url "https://download.kde.org/stable/frameworks/5.40/qqc2-desktop-style-5.40.0.tar.xz"
  sha256 "89ec1b98a3b9491f37cd3c13ff6ec047d773efb0fb697c14b9a8388fb0b6ed4a"
  desc "Style for Qt Quick Controls 2 to make it follow your desktop theme"
  homepage "https://www.kde.org"

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
