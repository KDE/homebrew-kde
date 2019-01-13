class Kf5Kapidox < Formula
  desc "Frameworks API Documentation Tools"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.54/kapidox-5.54.0.tar.xz"
  sha256 "cc90ff22cb810e011e63fa99122fcaa8a60504e2b61f43939fba2af621f3927f"

  head "git://anongit.kde.org/kapidox.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "qt" => :build

  def install
    args = std_cmake_args
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
