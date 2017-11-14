class Kf5Kauth < Formula
  url "https://download.kde.org/stable/frameworks/5.40/kauth-5.40.0.tar.xz"
  sha256 "5a27f1ef5af517662e8c0d350c7f0b20a78c6f44b5db190c16d07ba637945c1c"
  desc "Abstraction to system policy and authentication features"
  homepage "https://www.kde.org"

  head "git://anongit.kde.org/kauth.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "qt"
  depends_on "gpgme"
  depends_on "KDE-mac/kde/kf5-kcoreaddons"

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
