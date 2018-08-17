class Lokalize < Formula
  desc "Computer-aided translation system"
  homepage "https://www.kde.org/applications/development/lokalize/"
  url "https://download.kde.org/stable/applications/18.08.0/src/lokalize-18.08.0.tar.xz"
  sha256 "e577c1f0029b016a8ea3560ceb83a17682ef9fe9ad6381429fe3fdbe1419069e"

  head "git://anongit.kde.org/lokalize.git"

  depends_on "cmake" => :build
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
      system "cmake", "..", *args
      system "make", "install"
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
