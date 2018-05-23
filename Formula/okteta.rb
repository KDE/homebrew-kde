class Okteta < Formula
  desc "KDE hex editor for viewing and editing the raw data of files"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/applications/18.04.1/src/okteta-18.04.1.tar.xz"
  sha256 "af938035cbd6f27d2d88f43ad2c47890d3604f8c02217a62e9aa99cba26018ce"

  head "git://anongit.kde.org/okteta.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build

  depends_on "qca"
  depends_on "KDE-mac/kde/kf5-breeze-icons"
  depends_on "KDE-mac/kde/kf5-kcmutils"
  depends_on "KDE-mac/kde/kf5-knewstuff"
  depends_on "KDE-mac/kde/kf5-kparts"

  patch :DATA

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
    # Extract Qt plugin path
    qtpp = `#{Formula["qt"].bin}/qtpaths --plugin-dir`.chomp
    system "/usr/libexec/PlistBuddy",
      "-c", "Add :LSEnvironment:QT_PLUGIN_PATH string \"#{qtpp}\:#{HOMEBREW_PREFIX}/lib/qt5/plugins\"",
      "#{bin}/okteta.app/Contents/Info.plist"
  end

  def post_install
    system HOMEBREW_PREFIX/"bin/update-mime-database", HOMEBREW_PREFIX/"share/mime"
    ln_sf HOMEBREW_PREFIX/"share/icons/breeze/breeze-icons.rcc", HOMEBREW_PREFIX/"share/okteta/icontheme.rcc"
  end

  def caveats; <<~EOS
    You need to take some manual steps in order to make this formula work:
      ln -sf "$(brew --prefix)/share/okteta" "$HOME/Library/Application Support"
      ln -sf "$(brew --prefix)/share/config.kcfg" "$HOME/Library/Application Support"
      ln -sf "$(brew --prefix)/share/kxmlgui5" "$HOME/Library/Application Support"
      mkdir -p $HOME/Applications/KDE
      ln -sf "#{prefix}/bin/okteta.app" $HOME/Applications/KDE/
    EOS
  end
end

# Externalized the generation of the mimetypes
# Fix typo(?)

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

diff --git a/designer/CMakeLists.txt b/designer/CMakeLists.txt
index 653f4082..2567f20a 100644
--- a/designer/CMakeLists.txt
+++ b/designer/CMakeLists.txt
@@ -26,7 +26,7 @@ set_target_properties( oktetadesignerplugin PROPERTIES
     OUTPUT_NAME oktetawidgets
 )
 
-install( TARGETS oktetadesignerplugin  DESTINATION ${KDE_INSTALL_QTPLUGINDIR}/designer )
+install( TARGETS oktetadesignerplugin  DESTINATION ${KDE_INSTALL_PLUGINDIR}/designer )
 
 
 if( OKTETA_BUILD_EXAMPLES )
