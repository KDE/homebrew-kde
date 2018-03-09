class Kf5Kpeople < Formula
  desc "Library that provides access to all contacts and the people who hold them"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.44/kpeople-5.44.0.tar.xz"
  sha256 "2e7a9ba95410b2eb8b90332c0bb3d523e4c994f22fb45f7c16be17390efb120c"
  revision 1

  head "git://anongit.kde.org/kpeople.git"

  depends_on "cmake" => :build
  depends_on "gettext" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "KDE-mac/kde/kf5-kitemviews"
  depends_on "KDE-mac/kde/kf5-kservice"
  depends_on "KDE-mac/kde/kf5-kwidgetsaddons"

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

  def caveats; <<~EOS
    You need to take some manual steps in order to make this formula work:
      ln -sf "$(brew --prefix)/share/kf5" "$HOME/Library/Application Support"
      ln -sf "$(brew --prefix)/share/kservicetypes5" "$HOME/Library/Application Support"
    EOS
  end
end
