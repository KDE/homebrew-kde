class Kf5Kimageformats < Formula
  desc "Image format plugins for Qt5"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.71/kimageformats-5.71.0.tar.xz"
  sha256 "0d6d6a8664e4a01df27e9970ec9ec10a92c1d43a00a3e9ef0471d740b4c93d94"
  head "https://invent.kde.org/frameworks/kimageformats.git"
  revision 1

  depends_on "cmake" => [:build, :test]
  depends_on "kde-extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build
  depends_on "jasper"
  depends_on "openexr"
  depends_on "qt"

  depends_on "kde-karchive" => :optional

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
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
    assert_predicate lib/"qt5/plugins/imageformats/kimg_eps.so", :exist?
    assert_predicate share/"kservices5/qimageioplugins/eps.desktop", :exist?
  end
end
