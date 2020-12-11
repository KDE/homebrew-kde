class Drkonqi < Formula
  desc "Crash handler for KDE software"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/plasma/5.20.4/drkonqi-5.20.4.tar.xz"
  sha256 "55d4a166ee74c4a935c69cec64ecd8eb3fdd79aae8dcd996f6432a873be3fac8"
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
