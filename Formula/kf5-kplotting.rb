class Kf5Kplotting < Formula
  desc "Lightweight plotting framework"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.55/kplotting-5.55.0.tar.xz"
  sha256 "c7a32cb103d7c288abc711d9d40e132429cdebfe87d41b7c88f7dfbd7dd8c25a"

  head "git://anongit.kde.org/kplotting.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
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
