class Kf5Kapidox < Formula
  desc "Frameworks API Documentation Tools"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.44/kapidox-5.44.0.tar.xz"
  sha256 "8072d4d011779d8af292cb4875952201b71288aad6b198a9020050b7bd16fd2b"
  revision 1

  head "git://anongit.kde.org/kapidox.git"

  depends_on "qt" => :build
  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

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
