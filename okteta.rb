require "formula"

class Okteta < Formula
  desc "KDE hex editor for viewing and editing the raw data of files"
  homepage "http://www.kde.org/"
  url "https://download.kde.org/stable/applications/17.08.2/src/okteta-17.08.2.tar.xz"
  sha256 "31c2f00e187eeb13c8a9096e69c22dba649d564d7feb23e75644dc64772060b8"

  head "git://anongit.kde.org/okteta.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build

  depends_on "qt"
  depends_on "qca"
  depends_on "KDE-mac/kde/kf5-kbookmarks"
  depends_on "KDE-mac/kde/kf5-kcodecs"
  depends_on "KDE-mac/kde/kf5-kcompletion"
  depends_on "KDE-mac/kde/kf5-kconfigwidgets"
  depends_on "KDE-mac/kde/kf5-kdbusaddons"
  depends_on "KDE-mac/kde/kf5-ki18n"
  depends_on "KDE-mac/kde/kf5-kcmutils"
  depends_on "KDE-mac/kde/kf5-kio"
  depends_on "KDE-mac/kde/kf5-knewstuff"
  depends_on "KDE-mac/kde/kf5-kparts"
  depends_on "KDE-mac/kde/kf5-kservice"
  depends_on "KDE-mac/kde/kf5-solid"
  depends_on "KDE-mac/kde/kf5-kwidgetsaddons"
  depends_on "KDE-mac/kde/kf5-kxmlgui"

  patch :DATA

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

  def post_install
    system HOMEBREW_PREFIX/"bin/update-mime-database", HOMEBREW_PREFIX/"share/mime"
  end

  def caveats; <<-EOS.undent
    You need to take some manual steps in order to make this formula work (NOTE: the order is important!):
      ln -sf "$(brew --prefix)/share/okteta ~/Library/"Application Support"
      ln -sf "$(brew --prefix)/share/icons/breeze/breeze-icons.rcc" ~/Library/"Application Support"/okteta/icontheme.rcc
      mkdir -p ~/Applications/KDE
      ln -sf "#{prefix}/bin/okteta.app" ~/Applications/KDE/
    EOS
  end
end

__END__
--- a/mimetypes/CMakeLists.txt	2017-10-29 06:06:00.746991760 +0100
+++ b/mimetypes/CMakeLists.txt	2017-10-29 06:06:13.473170586 +0100
@@ -3,4 +3,6 @@
 find_package( SharedMimeInfo REQUIRED )
 
 install( FILES okteta.xml  DESTINATION ${KDE_INSTALL_MIMEDIR} )
-update_xdg_mimetypes( ${KDE_INSTALL_MIMEDIR} )
+
+# Need generate out of brew by update-mime-database
+#update_xdg_mimetypes( ${KDE_INSTALL_MIMEDIR} )

