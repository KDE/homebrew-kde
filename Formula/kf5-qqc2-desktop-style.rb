class Kf5Qqc2DesktopStyle < Formula
  desc "Style for Qt QC2 to follow your desktop theme"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.45/qqc2-desktop-style-5.45.0.tar.xz"
  sha256 "4ae78d9b3e00e90f4b36b4ea892a385f2be3ca0a3bbcc94f83de3101270782b5"

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
