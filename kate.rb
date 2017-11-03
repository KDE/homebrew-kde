require "formula"

class Kate < Formula
  desc "Advanced KDE Text Editor"
  homepage "http://kate-editor.org"
  url "https://download.kde.org/stable/applications/17.08.2/src/kate-17.08.2.tar.xz"
  sha256 "62456ab4ad1d12c810b75c3361a2b412d3f019161b8fc6511a43211f76828dd4"

  head "git://anongit.kde.org/kate.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "qt"
  depends_on "KDE-mac/kde/kf5-kactivities"
  depends_on "KDE-mac/kde/kf5-kconfig"
  depends_on "KDE-mac/kde/kf5-kdoctools"
  depends_on "KDE-mac/kde/kf5-kguiaddons"
  depends_on "KDE-mac/kde/kf5-ki18n"
  depends_on "KDE-mac/kde/kf5-kiconthemes"
  depends_on "KDE-mac/kde/kf5-kinit"
  depends_on "KDE-mac/kde/kf5-kjobwidgets"
  depends_on "KDE-mac/kde/kf5-kio"
  depends_on "KDE-mac/kde/kf5-kparts"
  depends_on "KDE-mac/kde/kf5-ktexteditor"
  depends_on "KDE-mac/kde/kf5-kwindowsystem"
  depends_on "KDE-mac/kde/kf5-kxmlgui"
  depends_on "KDE-mac/kde/kf5-kitemmodels"
  depends_on "KDE-mac/kde/kf5-knewstuff"
  depends_on "KDE-mac/kde/kf5-kwallet"
  depends_on "KDE-mac/kde/kf5-breeze-icons"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"
    args << "-DCMAKE_INSTALL_BUNDLEDIR=#{prefix}/bin"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end

  def caveats; <<-EOS.undent
    You need to take some manual steps in order to make this formula work:
      ln -sf "$(brew --prefix)/share/katepart5 ~/Library/"Application Support"
      ln -sf "$(brew --prefix)/share/kateporoject ~/Library/"Application Support"
      ln -sf "$(brew --prefix)/share/katexmltools ~/Library/"Application Support"
      mkdir -p ~/Library/"Application Support"/kate
      ln -sf "$(brew --prefix)/share/icons/breeze/breeze-icons.rcc" ~/Library/"Application Support"/kate/icontheme.rcc
      mkdir -p ~/Applications/KDE
      ln -sf "#{prefix}/bin/kate.app" ~/Applications/KDE/
      ln -sf "#{prefix}/bin/kwrite.app" ~/Applications/KDE/
    EOS
  end

  test do
    assert `/Applications/KDE/kate.app/Contents/MacOS/kate --help | grep -- --help` =~ /--help/
  end
end
