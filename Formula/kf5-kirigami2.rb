class Kf5Kirigami2 < Formula
  desc "QtQuick based components set"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.56/kirigami2-5.56.0.tar.xz"
  sha256 "fea01ea5d277a1d415a3b2f0fe8f7659bf345933c4fd1c78c5f92fab40c97e5d"

  head "git://anongit.kde.org/kirigami.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "qt"
  depends_on "KDE-mac/kde/kf5-plasma-framework" => :optional

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
      ln -sfv "$(brew --prefix)/share/kpackage" "$HOME/Library/Application Support"
  EOS
  end
end
