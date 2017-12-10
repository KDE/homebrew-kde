class Kf5Kdoctools < Formula
  desc "Documentation generation from docbook"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.41/kdoctools-5.41.0.tar.xz"
  sha256 "9ac9b92f549ef00e261033ffa349f239fb22503c0b5aaf9bded0966af21a661b"
  revision 1

  head "git://anongit.kde.org/kdoctools.git"

  depends_on "cmake" => :build
  depends_on "perl" => :build
  depends_on "gettext" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-ki18n" => :build

  depends_on "docbook-xsl"
  depends_on "libxml2"
  depends_on "libxslt"
  depends_on "KDE-mac/kde/kf5-karchive"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end

  def caveats; <<-EOS.undent
    Before install of this formula you need to run:
      brew install cpanminus
      cpanm URI

    You need to take some manual steps in order to make this formula work:
      ln -sf "$(brew --prefix)/share/kf5" "$HOME/Library/Application Support"
    EOS
  end
end
