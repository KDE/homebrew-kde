class Kf5Kdbusaddons < Formula
  desc "Addons to QtDBus"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.45/kdbusaddons-5.45.0.tar.xz"
  sha256 "e62b0ce98c345ddd0c214af4a57f6d44085bbe9bb6342c5b682cc8925ac93f1c"

  head "git://anongit.kde.org/kdbusaddons.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "shared-mime-info" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "qt"
  depends_on "dbus"

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
