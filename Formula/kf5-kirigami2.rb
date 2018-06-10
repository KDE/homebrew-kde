class Kf5Kirigami2 < Formula
  desc "QtQuick based components set"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.47/kirigami2-5.47.0.tar.xz"
  sha256 "ed2dd9e3a56f4728aca40c74ab02d48f9dda8d140b20328c5b29825f5683aad5"

  head "git://anongit.kde.org/kirigami.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "KDE-mac/kde/kf5-plasma-framework" => :optional

  depends_on "qt"

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

  def caveats; <<~EOS
    You need to take some manual steps in order to make this formula work:
      ln -sf "$(brew --prefix)/share/kpackage" "$HOME/Library/Application Support"
     EOS
  end
end
