class Kf5Kimageformats < Formula
  desc "Image format plugins for Qt5"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.41/kimageformats-5.41.0.tar.xz"
  sha256 "1ae1658886293934ec95f9a39dac438c3a4be71514d7f6de1529d8a18911ae85"
  revision 1

  head "git://anongit.kde.org/kimageformats.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "KDE-mac/kde/kf5-karchive" => :optional

  depends_on "qt"
  depends_on "openexr"
  depends_on "jasper"

  patch :DATA

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end

  def caveats; <<-EOS.undent
    You need to take some manual steps in order to make this formula work:
      ln -sf "$(brew --prefix)/share/kservices5" "$HOME/Library/Application Support"
     EOS
  end
end

# Fix typo(?)
__END__
diff --git a/src/imageformats/CMakeLists.txt b/src/imageformats/CMakeLists.txt
index 0db2ae8..0a4092c 100644
--- a/src/imageformats/CMakeLists.txt
+++ b/src/imageformats/CMakeLists.txt
@@ -11,7 +11,7 @@ if (BUILD_EPS_PLUGIN)
         add_library(kimg_eps MODULE eps.cpp)
         target_link_libraries(kimg_eps  Qt5::Gui Qt5::PrintSupport)
 
-        install(TARGETS kimg_eps  DESTINATION ${KDE_INSTALL_QTPLUGINDIR}/imageformats/)
+        install(TARGETS kimg_eps  DESTINATION ${KDE_INSTALL_PLUGINDIR}/imageformats/)
         install(FILES eps.desktop DESTINATION ${KDE_INSTALL_KSERVICES5DIR}/qimageioplugins/)
     endif()
 endif()
@@ -29,7 +29,7 @@ if(OpenEXR_FOUND)
     target_link_libraries(kimg_exr Qt5::Gui OpenEXR::IlmImf)
     kde_target_enable_exceptions(kimg_exr PRIVATE)
 
-    install(TARGETS kimg_exr  DESTINATION ${KDE_INSTALL_QTPLUGINDIR}/imageformats/)
+    install(TARGETS kimg_exr  DESTINATION ${KDE_INSTALL_PLUGINDIR}/imageformats/)
     install(FILES exr.desktop DESTINATION ${KDE_INSTALL_KSERVICES5DIR}/qimageioplugins/)
 endif()
 
@@ -38,7 +38,7 @@ endif()
 add_library(kimg_pcx MODULE pcx.cpp)
 target_link_libraries(kimg_pcx  Qt5::Gui)
 
-install(TARGETS kimg_pcx  DESTINATION ${KDE_INSTALL_QTPLUGINDIR}/imageformats/)
+install(TARGETS kimg_pcx  DESTINATION ${KDE_INSTALL_PLUGINDIR}/imageformats/)
 install(FILES pcx.desktop DESTINATION ${KDE_INSTALL_KSERVICES5DIR}/qimageioplugins/)
 
 ##################################
@@ -46,7 +46,7 @@ install(FILES pcx.desktop DESTINATION ${KDE_INSTALL_KSERVICES5DIR}/qimageioplugi
 add_library(kimg_pic MODULE pic.cpp)
 target_link_libraries(kimg_pic Qt5::Gui)
 
-install(TARGETS kimg_pic  DESTINATION ${KDE_INSTALL_QTPLUGINDIR}/imageformats/)
+install(TARGETS kimg_pic  DESTINATION ${KDE_INSTALL_PLUGINDIR}/imageformats/)
 install(FILES pic.desktop DESTINATION ${KDE_INSTALL_KSERVICES5DIR}/qimageioplugins/)
 
 ##################################
@@ -54,7 +54,7 @@ install(FILES pic.desktop DESTINATION ${KDE_INSTALL_KSERVICES5DIR}/qimageioplugi
 add_library(kimg_psd MODULE psd.cpp)
 target_link_libraries(kimg_psd Qt5::Gui)
 
-install(TARGETS kimg_psd  DESTINATION ${KDE_INSTALL_QTPLUGINDIR}/imageformats/)
+install(TARGETS kimg_psd  DESTINATION ${KDE_INSTALL_PLUGINDIR}/imageformats/)
 install(FILES psd.desktop DESTINATION ${KDE_INSTALL_KSERVICES5DIR}/qimageioplugins/)
 
 ##################################
@@ -62,7 +62,7 @@ install(FILES psd.desktop DESTINATION ${KDE_INSTALL_KSERVICES5DIR}/qimageioplugi
 add_library(kimg_ras MODULE ras.cpp)
 target_link_libraries(kimg_ras  Qt5::Gui)
 
-install(TARGETS kimg_ras  DESTINATION ${KDE_INSTALL_QTPLUGINDIR}/imageformats/)
+install(TARGETS kimg_ras  DESTINATION ${KDE_INSTALL_PLUGINDIR}/imageformats/)
 install(FILES ras.desktop DESTINATION ${KDE_INSTALL_KSERVICES5DIR}/qimageioplugins/)
 
 ##################################
@@ -70,7 +70,7 @@ install(FILES ras.desktop DESTINATION ${KDE_INSTALL_KSERVICES5DIR}/qimageioplugi
 add_library(kimg_rgb MODULE rgb.cpp)
 target_link_libraries(kimg_rgb  Qt5::Gui)
 
-install(TARGETS kimg_rgb  DESTINATION ${KDE_INSTALL_QTPLUGINDIR}/imageformats/)
+install(TARGETS kimg_rgb  DESTINATION ${KDE_INSTALL_PLUGINDIR}/imageformats/)
 install(FILES rgb.desktop DESTINATION ${KDE_INSTALL_KSERVICES5DIR}/qimageioplugins/)
 
 ##################################
@@ -78,7 +78,7 @@ install(FILES rgb.desktop DESTINATION ${KDE_INSTALL_KSERVICES5DIR}/qimageioplugi
 add_library(kimg_tga MODULE tga.cpp)
 target_link_libraries(kimg_tga  Qt5::Gui)
 
-install(TARGETS kimg_tga  DESTINATION ${KDE_INSTALL_QTPLUGINDIR}/imageformats/)
+install(TARGETS kimg_tga  DESTINATION ${KDE_INSTALL_PLUGINDIR}/imageformats/)
 install(FILES tga.desktop DESTINATION ${KDE_INSTALL_KSERVICES5DIR}/qimageioplugins/)
 
 ##################################
@@ -86,7 +86,7 @@ install(FILES tga.desktop DESTINATION ${KDE_INSTALL_KSERVICES5DIR}/qimageioplugi
 add_library(kimg_xcf MODULE xcf.cpp)
 target_link_libraries(kimg_xcf Qt5::Gui)
 
-install(TARGETS kimg_xcf  DESTINATION ${KDE_INSTALL_QTPLUGINDIR}/imageformats/)
+install(TARGETS kimg_xcf  DESTINATION ${KDE_INSTALL_PLUGINDIR}/imageformats/)
 install(FILES xcf.desktop DESTINATION ${KDE_INSTALL_KSERVICES5DIR}/qimageioplugins/)
 
 ##################################
@@ -96,13 +96,13 @@ if (KF5Archive_FOUND)
     add_library(kimg_kra MODULE kra.cpp)
     target_link_libraries(kimg_kra Qt5::Gui KF5::Archive)
 
-    install(TARGETS kimg_kra  DESTINATION ${KDE_INSTALL_QTPLUGINDIR}/imageformats/)
+    install(TARGETS kimg_kra  DESTINATION ${KDE_INSTALL_PLUGINDIR}/imageformats/)
     install(FILES kra.desktop DESTINATION ${KDE_INSTALL_KSERVICES5DIR}/qimageioplugins/)
 
     add_library(kimg_ora MODULE ora.cpp)
     target_link_libraries(kimg_ora Qt5::Gui KF5::Archive)
 
-    install(TARGETS kimg_ora  DESTINATION ${KDE_INSTALL_QTPLUGINDIR}/imageformats/)
+    install(TARGETS kimg_ora  DESTINATION ${KDE_INSTALL_PLUGINDIR}/imageformats/)
     install(FILES ora.desktop DESTINATION ${KDE_INSTALL_KSERVICES5DIR}/qimageioplugins/)
 
 endif()
