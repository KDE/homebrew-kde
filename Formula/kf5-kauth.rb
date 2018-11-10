class Kf5Kauth < Formula
  desc "Abstraction to system policy and authentication features"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.52/kauth-5.52.0.tar.xz"
  sha256 "b5f7a8c4e13dfcb904d0767e87354420cf385d1e02e53d4a5bb329bc71f72079"

  head "git://anongit.kde.org/kauth.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "gpgme"
  depends_on "KDE-mac/kde/kf5-kcoreaddons"

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
