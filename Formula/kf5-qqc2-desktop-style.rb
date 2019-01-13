class Kf5Qqc2DesktopStyle < Formula
  desc "Style for Qt QC2 to follow your desktop theme"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.54/qqc2-desktop-style-5.54.0.tar.xz"
  sha256 "c8aff0d5f5c8e2f08749f5b83eec0722fe0dbd8e63ff42fdb7aa97cc0c1b1cea"

  head "git://anongit.kde.org/qqc2-desktop-style.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "KDE-mac/kde/kf5-kconfigwidgets" => :build
  depends_on "KDE-mac/kde/kf5-kiconthemes" => :build
  depends_on "KDE-mac/kde/kf5-kirigami2" => :build
  depends_on "qt"

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
