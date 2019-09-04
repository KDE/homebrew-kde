class Drkonqi < Formula
  desc "The KDE Crash Handler"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/plasma/5.16.5/drkonqi-5.16.5.tar.xz"
  sha256 "b4ae1518108c2d3ccbc533708801b52b83b7e9efd6eed9f1ee9d67936b9e78ff"

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
