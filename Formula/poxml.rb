class Poxml < Formula
  desc "Translates DocBook XML files using gettext po files"
  homepage "https://www.kde.org/applications/development/"
  url "https://download.kde.org/stable/applications/18.04.2/src/poxml-18.04.2.tar.xz"
  sha256 "2b2ac0e88eed1cc3bb67b1be78d20264e5e2edb0ddb004a9d00c635ff36cd096"
  head "git://anongit.kde.org/poxml.git"

  depends_on "cmake" => :build
  depends_on "gettext"
  depends_on "KDE-mac/kde/kf5-kdoctools"
  depends_on "qt"

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
      ln -sf "$(brew --prefix)/opt/poxml/bin/po2xml.app" $HOME/Applications/KDE/
      ln -sf "$(brew --prefix)/opt/poxml/bin/split2po.app" $HOME/Applications/KDE/
      ln -sf "$(brew --prefix)/opt/poxml/bin/swappo.app" $HOME/Applications/KDE/
      ln -sf "$(brew --prefix)/opt/poxml/bin/xml2pot.app" $HOME/Applications/KDE/
  EOS
  end

  test do
    assert_includes "english-XML", `$(brew --prefix)/opt/poxml/bin/po2xml.app/Contents/MacOS/po2xml`
  end
end
