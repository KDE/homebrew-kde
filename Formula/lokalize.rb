class Lokalize < Formula
  desc "Computer-aided translation system"
  homepage "https://www.kde.org/applications/development/lokalize/"
  url "https://download.kde.org/stable/applications/18.12.0/src/lokalize-18.12.0.tar.xz"
  sha256 "d8541a738737b2628c09d4cdf579e55ed9b7598e77b3859b65b69b8100e9361f"

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
