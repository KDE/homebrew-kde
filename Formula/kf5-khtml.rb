class Kf5Khtml < Formula
  desc "KHTML APIs"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.58/portingAids/khtml-5.58.0.tar.xz"
  sha256 "f75635e4d0ad9816953bbd0f8c18aea7cd470dc130a6294fa1d32c37bd66dcff"
  head "git://anongit.kde.org/khtml.git"

  depends_on "cmake" => :build
  depends_on "gperf" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "ninja" => :build

  depends_on "giflib"
  depends_on "jpeg"
  depends_on "KDE-mac/kde/kf5-kjs"
  depends_on "KDE-mac/kde/kf5-kparts"
  depends_on "KDE-mac/kde/phonon"
  depends_on "libpng"
  depends_on "openssl"
  depends_on "zlib"

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

  def caveats; <<~EOS
    You need to take some manual steps in order to make this formula work:
      "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
  EOS
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5KHtml REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
