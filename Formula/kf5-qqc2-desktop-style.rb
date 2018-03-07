class Kf5Qqc2DesktopStyle < Formula
  desc "Style for Qt Quick Controls 2 to make it follow your desktop theme"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.42/qqc2-desktop-style-5.42.0.tar.xz"
  sha256 "d3f2f2d2faab02724800186cd0e90fe1dc60e9935f1ee4de0d413ba8197434ab"
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
