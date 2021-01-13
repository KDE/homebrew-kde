class Kf5Kdoctools < Formula
  desc "Documentation generation from docbook"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.78/kdoctools-5.78.0.tar.xz"
  sha256 "7a08eef3d7c0e4eac7d46ddc0d25942e008907bcac10ed27bca02a1169e2cf62"
  head "https://invent.kde.org/frameworks/kdoctools.git"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "gettext" => :build
  depends_on "kde-extra-cmake-modules" => [:build, :test]
  depends_on "kde-ki18n" => :build
  depends_on "ninja" => :build
  depends_on "perl" => :build

  depends_on "docbook-xsl"
  depends_on "kde-karchive"
  depends_on "libxml2"
  depends_on "libxslt"

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
    (testpath/"CMakeLists.txt").write("find_package(KF5DocTools REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
