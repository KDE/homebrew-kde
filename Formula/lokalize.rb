class Lokalize < Formula
  desc "Computer-aided translation system"
  homepage "https://www.kde.org/applications/development/lokalize/"
  url "https://download.kde.org/stable/applications/18.12.3/src/lokalize-18.12.3.tar.xz"
  sha256 "cce11b9384d27006855a141d2241a67d05679baa7096db2311c49a78bd642fed"

  revision 1
  head "git://anongit.kde.org/lokalize.git"
  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "gettext"
  depends_on "hunspell"
  depends_on "KDE-mac/kde/kf5-kross"
  depends_on "poxml"
  depends_on "qt"
  depends_on "translate-toolkit"
  depends_on "subversion" => :optional

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"
    args << "-DCMAKE_INSTALL_BUNDLEDIR=#{bin}"

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end

  def caveats; <<~EOS
    You need to take some manual steps in order to make this formula work:
      mkdir -pv "$HOME/Applications/KDE"
      ln -sfv "$(brew --prefix)/opt/lokalize/bin/lokalize.app" "$HOME/Applications/KDE/"
  EOS
  end

  test do
    assert `"#{bin}"/lokalize.app/Contents/MacOS/lokalize --help | grep -- --help` =~ /--help/
  end
end
