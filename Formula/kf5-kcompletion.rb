class Kf5Kcompletion < Formula
  desc "Text completion helpers and widgets"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.71/kcompletion-5.71.0.tar.xz"
  sha256 "bf0b6ce1ee133900f169662dbd35da6f766d3e4e02c0c102a9402e20450a22a4"
  head "git://anongit.kde.org/kcompletion.git"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "kde-extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "KDE-mac/kde/kf5-kconfig"
  depends_on "KDE-mac/kde/kf5-kwidgetsaddons"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"
    args << "-DKDE_INSTALL_QTPLUGINDIR=lib/qt5/plugins"

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Completion REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
