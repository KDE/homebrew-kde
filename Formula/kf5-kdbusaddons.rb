class Kf5Kdbusaddons < Formula
  desc "Addons to QtDBus"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.56/kdbusaddons-5.56.0.tar.xz"
  sha256 "b930918ccece1d80aaf0eb770d4e17e5926d7da3a97d1f8506f28829d267b972"

  revision 1
  head "git://anongit.kde.org/kdbusaddons.git"
  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "ninja" => :build

  depends_on "dbus"
  depends_on "qt"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
