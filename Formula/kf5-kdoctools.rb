class Kf5Kdoctools < Formula
  desc "Documentation generation from docbook"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.61/kdoctools-5.61.0.tar.xz"
  sha256 "e48d8f8f075171c6b83189999a10552c772c6a7e9a115a2643414f9ecec77c6f"
  head "git://anongit.kde.org/kdoctools.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "gettext" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-ki18n" => :build
  depends_on "ninja" => :build
  depends_on "perl" => :build

  depends_on "docbook-xsl"
  depends_on "KDE-mac/kde/kf5-karchive"
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

  def caveats; <<~EOS
    Before install of this formula you need to run:
      brew install perl
      export PERL_MM_USE_DEFAULT=1
      cpan URI URI::Escape

    You need to take some manual steps in order to make this formula work:
      "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
  EOS
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5DocTools REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
