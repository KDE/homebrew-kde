class Elisa < Formula
  desc "KDE Music Player"
  homepage "https://community.kde.org/Elisa"
  head "https://anongit.kde.org/elisa.git"

  depends_on "cmake" => :build
  depends_on "gettext" => :build
  depends_on "kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kcmutils"
  depends_on "KDE-mac/kde/kf5-kconfig"
  depends_on "KDE-mac/kde/kf5-kconfigwidgets"
  depends_on "KDE-mac/kde/kf5-kcoreaddons"
  depends_on "KDE-mac/kde/kf5-kdbusaddons"
  depends_on "KDE-mac/kde/kf5-kfilemetadata"
  depends_on "KDE-mac/kde/kf5-ki18n"
  depends_on "KDE-mac/kde/kf5-kxmlgui"

  def install
    args = std_cmake_args
    args << "-DCMAKE_INSTALL_PREFIX=#{prefix}"
    args << "-DCMAKE_INSTALL_LIBDIR=#{lib}"
    args << "-DCMAKE_INSTALL_BUNDLEDIR=#{bin}"
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
      ln -sfv "$(brew --prefix)/share/kservices5" "$HOME/Library/Application Support"
      ln -sfv "$(brew --prefix)/share/metainfo" "$HOME/Library/Application Support"
      ln -sfv "$(brew --prefix)/share/kpackage "$HOME/Library/Application Support"
      ln -sfv "$(brew --prefix)/share/icons" "$HOME/Library/Application Support"
      mkdir -pv "$HOME/Applications/KDE"
      ln -sfv "$(brew --prefix)/opt/elisa/bin/elisa.app" "$HOME/Applications/KDE/"
  EOS
  end
end
