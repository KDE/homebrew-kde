class Kf5Kparts < Formula
  desc "Document centric plugin system"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.53/kparts-5.53.0.tar.xz"
  sha256 "355aa9dc232c80433a2141020b487160fe065458a3fc8abe9cc436038e5bdf31"

  head "git://anongit.kde.org/kparts.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "KDE-mac/kde/kf5-kio"
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
      ln -sfv "$(brew --prefix)/share/kdevappwizard" "$HOME/Library/Application Support"
      ln -sfv "$(brew --prefix)/share/kservicetypes5" "$HOME/Library/Application Support"
  EOS
  end
end
