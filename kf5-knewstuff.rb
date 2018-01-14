class Kf5Knewstuff < Formula
  desc "Support for downloading application assets from the network"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.42/knewstuff-5.42.0.tar.xz"
  sha256 "e625cb21dba7780ee8936153e7ba0f57bf81c929fb6ccb4b15eef763aeaf4f44"
  revision 1

  head "git://anongit.kde.org/knewstuff.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "KDE-mac/kde/kf5-kirigami2" => :optional

  depends_on "KDE-mac/kde/kf5-kio"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end

  def caveats; <<-EOS.undent
    You need to take some manual steps in order to make this formula work:
      ln -sf "$(brew --prefix)/share/kf5" "$HOME/Library/Application Support"
    EOS
  end
end
