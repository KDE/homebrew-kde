class Kf5Kpeople < Formula
  desc "Provides access to all contacts and the people"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.70/kpeople-5.70.0.tar.xz"
  sha256 "d4e7e4f29a2d7e21c418ff930d7750b9fe15994e88d5f3d0e934c99b82a71bb6"
  head "git://anongit.kde.org/kpeople.git"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "gettext" => :build
  depends_on "graphviz" => :build
  depends_on "kde-extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "KDE-mac/kde/kf5-kitemviews"
  depends_on "KDE-mac/kde/kf5-kservice"
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

  def caveats
    <<~EOS
      You need to take some manual steps in order to make this formula work:
        "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
    EOS
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5People REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
