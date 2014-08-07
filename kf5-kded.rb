require "formula"

class Kf5Kded < Formula
  url "http://download.kde.org/stable/frameworks/5.1.0/kded-5.1.0.tar.xz"
  sha1 "f1740090c171555ec931021e44f43b2b8709421d"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kded.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"
  depends_on "gettext" => :build

  patch :DATA

  def install
    args = std_cmake_args
    args << "-DCMAKE_CXX_FLAGS='-D_DARWIN_C_SOURCE'"

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end

__END__
diff --git a/src/CMakeLists.txt b/src/CMakeLists.txt
index 9b1888e..3a5d98d 100644
--- a/src/CMakeLists.txt
+++ b/src/CMakeLists.txt
@@ -5,13 +5,13 @@ set(kded_KDEINIT_SRCS kded.cpp kdedadaptor.cpp
 kf5_add_kdeinit_executable(kded5 ${kded_KDEINIT_SRCS})
 
 if (APPLE)
-    set_target_properties(kded5 PROPERTIES MACOSX_BUNDLE_INFO_PLIST ${CMAKE_CURRENT_SOURCE_DIR}/Info.plist.template)
-    set_target_properties(kded5 PROPERTIES MACOSX_BUNDLE_GUI_IDENTIFIER "org.kded.kded5")
-    set_target_properties(kded5 PROPERTIES MACOSX_BUNDLE_BUNDLE_NAME "KDE Daemon")
+    set_target_properties(kded5 PROPERTIES MACOSX_BUNDLE FALSE)
+#    set_target_properties(kded5 PROPERTIES MACOSX_BUNDLE_INFO_PLIST ${CMAKE_CURRENT_SOURCE_DIR}/Info.plist.template)
+#    set_target_properties(kded5 PROPERTIES MACOSX_BUNDLE_GUI_IDENTIFIER "org.kded.kded5")
+#    set_target_properties(kded5 PROPERTIES MACOSX_BUNDLE_BUNDLE_NAME "KDE Daemon")
 endif ()
 
 target_link_libraries(kdeinit_kded5
-    Qt5::Widgets # QApplication
     KF5::Service # Needed for ksycoca.h
     KF5::CoreAddons # Needed for KDirWatch
     KF5::DBusAddons # Needed for kdedmodule.h
diff --git a/src/kded.cpp b/src/kded.cpp
index 6a3c493..1eb2674 100644
--- a/src/kded.cpp
+++ b/src/kded.cpp
@@ -29,7 +29,7 @@
 #include <QtCore/QDir>
 #include <QtCore/QFile>
 #include <QtCore/QTimer>
-#include <QApplication>
+#include <QtCore/QCoreApplication>
 
 #include <QDBusConnection>
 #include <QDBusInterface>
@@ -759,10 +759,10 @@ extern "C" Q_DECL_EXPORT int kdemain(int argc, char *argv[])
         return 0;
     }
 
-    QApplication app(argc, argv);
+    QCoreApplication app(argc, argv);
     setupAppInfo(&app);
-    app.setApplicationDisplayName("KDE Daemon");
-    app.setQuitOnLastWindowClosed(false);
+    //app.setApplicationDisplayName("KDE Daemon");
+    //app.setQuitOnLastWindowClosed(false);
 
     KDBusService service(KDBusService::Unique);
 
