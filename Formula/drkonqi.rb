class Drkonqi < Formula
  desc "The KDE Crash Handler"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/plasma/5.19.3/drkonqi-5.19.3.tar.xz"
  sha256 "879fef551b22755aa134987dd028caaa2901468afa2d5b87e237d63575c55405"
  head "https://invent.kde.org/plasma/drkonqi.git"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "kde-extra-cmake-modules" => [:build, :test]
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
