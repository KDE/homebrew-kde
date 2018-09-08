class Kf5Kapidox < Formula
  desc "Frameworks API Documentation Tools"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.50/kapidox-5.50.0.tar.xz"
  sha256 "1f575d7f0cc7c2a6f76e2c2895f1f6e1cea5cea44897d4cd433af9662f061786"

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
