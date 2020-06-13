class Kf5Knewstuff < Formula
  desc "Support for downloading application assets from the network"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.71/knewstuff-5.71.0.tar.xz"
  sha256 "aba867855d69641f73db30405e787fc9ea22e3386a45be9626ba84cbe208f855"
  head "git://anongit.kde.org/knewstuff.git"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "kde-extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "KDE-mac/kde/kf5-kio"

  depends_on "KDE-mac/kde/kf5-kirigami2" => :optional

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

  def caveats
    <<~EOS
      You need to take some manual steps in order to make this formula work:
        "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
    EOS
  end

  test do
    (testpath/"CMakeLists.txt").write <<~EOS
      find_package(ECM REQUIRED)
      set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH} ${ECM_KDE_MODULE_DIR})
      find_package(KF5NewStuff REQUIRED)
      find_package(KF5NewStuffCore REQUIRED)
      find_package(KF5NewStuffQuick REQUIRED)
    EOS
    system "cmake", ".", "-Wno-dev"
  end
end
