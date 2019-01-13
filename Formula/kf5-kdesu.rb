class Kf5Kdesu < Formula
  desc "Integration with su for elevated privileges"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.54/kdesu-5.54.0.tar.xz"
  sha256 "59d1d057f380c4efab9047815be1dc616c4ac528afb6b8a29fd92c812b0c1ce2"

  head "git://anongit.kde.org/kdesu.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "gettext" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "KDE-mac/kde/kf5-kpty"
  depends_on "KDE-mac/kde/kf5-kservice"
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
