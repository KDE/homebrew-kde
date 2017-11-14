class Kf5Kapidox < Formula
  url "https://download.kde.org/stable/frameworks/5.40/kapidox-5.40.0.tar.xz"
  sha256 "feb615a09ab5381a0f5fb4b85fdba7d338ad8b5b6ebdd8c20735d72e7b5d76f3"
  desc "Frameworks API Documentation Tools"
  homepage "https://www.kde.org"

  head "git://anongit.kde.org/kapidox.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "qt"

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
end
