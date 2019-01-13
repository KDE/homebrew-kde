class Kf5Kwidgetsaddons < Formula
  desc "Addons to QtWidgets"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.54/kwidgetsaddons-5.54.0.tar.xz"
  sha256 "f009b49ae0eb6deaa814defcfbf7ed8a27b8d874a11a0754855fb917219d1d07"

  head "git://anongit.kde.org/kwidgetsaddons.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "qt"

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
      ln -sfv "$(brew --prefix)/share/kf5" "$HOME/Library/Application Support"
  EOS
  end
end
