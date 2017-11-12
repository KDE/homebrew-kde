class Kf5Kpeople < Formula
  url "https://download.kde.org/stable/frameworks/5.40/kpeople-5.40.0.tar.xz"
  sha256 "79d550a16d6f68f0ceafbce1c34e39eb95256b95c8940e9cfff3317ec704daf9"
  desc "A Library that provides access to all contacts and the people who hold them"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kpeople.git"

  depends_on "cmake" => :build
  depends_on "gettext" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "qt"
  depends_on "KDE-mac/kde/kf5-kservice"
  depends_on "KDE-mac/kde/kf5-kwidgetsaddons"
  depends_on "KDE-mac/kde/kf5-kitemviews"


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

