class Kf5Kunitconversion < Formula
  desc "Support for unit conversion"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.56/kunitconversion-5.56.0.tar.xz"
  sha256 "848472340fb24fdb57c0ea60bc4bafcb2b3a26d0eede21a2e8b39e730d6bc5cd"

  revision 1
  head "git://anongit.kde.org/kunitconversion.git"
  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "gettext" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "ninja" => :build

  depends_on "KDE-mac/kde/kf5-ki18n"

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
