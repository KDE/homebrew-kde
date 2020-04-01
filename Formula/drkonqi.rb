class Drkonqi < Formula
  desc "The KDE Crash Handler"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/plasma/5.18.4/drkonqi-5.18.4.1.tar.xz"
  sha256 "4b3072c4ef571764897a9aa1c26e63d57f9d2fd55c6f932f489f2e30f8afb6d2"

  head "git://anongit.kde.org/drkonqi.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "ninja" => :build

  depends_on "KDE-mac/kde/kf5-kidletime"
  depends_on "KDE-mac/kde/kf5-kxmlrpcclient"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"
    args << "-DKDE_INSTALL_QTPLUGINDIR=lib/qt5/plugins"
    args << "-DCMAKE_INSTALL_LIBEXECDIR=lib"

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end

  test do
    assert_predicate lib/"drkonqi", :exist?
  end
end
