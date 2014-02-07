require "formula"

class Kf5Kwindowsystem < Formula
  homepage "http://www.kde.org/"
#  url "http://download.kde.org/unstable/frameworks/4.95.0/kwindowsystem-4.95.0.tar.xz"
#  sha1 ""

  head 'git://anongit.kde.org/kwindowsystem.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5"

  def patches
    DATA
  end

  def install
    args = std_cmake_args
    args << "-DCMAKE_PREFIX_PATH=\"#{Formula.factory('qt5').opt_prefix};#{Formula.factory('kf5-extra-cmake-modules').opt_prefix}\""
    args << "-DCMAKE_CXX_FLAGS='-D_DARWIN_C_SOURCE -DQT_MAC_USE_COCOA'"

    system "cmake", ".", *args
    system "make", "install"
  end
end

__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 6cebf0c..976d018 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -11,6 +11,7 @@ include(GenerateExportHeader)
 include(CMakePackageConfigHelpers)
 include(ECMSetupVersion)
 include(ECMGenerateHeaders)
+include(CMakeFindFrameworks)
 
 set(KF5_VERSION "4.96.0")
 
@@ -26,12 +27,13 @@ include(KDEInstallDirs)
 include(KDEFrameworkCompilerSettings)
 include(KDECMakeSettings)
 
-if(NOT WIN32)
+if(NOT WIN32 AND NOT APPLE)
     find_package(Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED X11Extras)
 endif()
 
 if (APPLE)
-   find_package(Carbon REQUIRED)
+    cmake_find_frameworks(Carbon)
+    cmake_find_frameworks(CoreFoundation)
 endif ()
 
 if(WIN32)
diff --git a/src/CMakeLists.txt b/src/CMakeLists.txt
index 9c1d452..5dba0d6 100644
--- a/src/CMakeLists.txt
+++ b/src/CMakeLists.txt
@@ -39,6 +39,7 @@ if (APPLE)
 # FIXME: adjust kwindowinfo_mac to inherit from KWindowInfoPrivate
 #                                                 kwindowinfo_mac.cpp
 )
+  set(platformLinkLibraries "-framework CoreFoundation -framework Carbon")
 endif ()
 
 if (WIN32)
diff --git a/src/kkeyserver_mac.cpp b/src/kkeyserver_mac.cpp
index b08eaf6..4f8091b 100644
--- a/src/kkeyserver_mac.cpp
+++ b/src/kkeyserver_mac.cpp
@@ -19,8 +19,6 @@
 
 #include "kkeyserver_mac.h"
 
-#include <QtCore/QCOORD>
-
 #ifdef Q_OS_MAC // Only compile this module if we're compiling for Mac OS X
 
 #include <QDebug>
diff --git a/src/kkeyserver_mac.h b/src/kkeyserver_mac.h
index d06c77a..e5f7ba7 100644
--- a/src/kkeyserver_mac.h
+++ b/src/kkeyserver_mac.h
@@ -22,6 +22,8 @@
 
 #include <kwindowsystem_export.h>
 
+#include <QList>
+
 namespace KKeyServer
 {
 /**
diff --git a/src/kstartupinfo.cpp b/src/kstartupinfo.cpp
index d002251..5c12eda 100644
--- a/src/kstartupinfo.cpp
+++ b/src/kstartupinfo.cpp
@@ -1244,9 +1244,11 @@ QString KStartupInfoData::Private::to_text() const
     if (!icon.isEmpty()) {
         ret += QString::fromLatin1(" ICON=\"%1\"").arg(icon);
     }
+#if KWINDOWSYSTEM_HAVE_X11
     if (desktop != 0)
         ret += QString::fromLatin1(" DESKTOP=%1")
                .arg(desktop == NET::OnAllDesktops ? NET::OnAllDesktops : desktop - 1);   // spec counts from 0
+#endif
     if (!wmclass.isEmpty()) {
         ret += QString::fromLatin1(" WMCLASS=\"%1\"").arg(QString(wmclass));
     }
@@ -1309,8 +1311,10 @@ KStartupInfoData::KStartupInfoData(const QString &txt_P) : d(new Private)
             d->icon = get_str(*it);
         } else if ((*it).startsWith(desktop_str)) {
             d->desktop = get_num(*it);
+#if KWINDOWSYSTEM_HAVE_X11
             if (d->desktop != NET::OnAllDesktops)
                 ++d->desktop; // spec counts from 0
+#endif
         } else if ((*it).startsWith(wmclass_str)) {
             d->wmclass = get_cstr(*it);
         } else if ((*it).startsWith(hostname_str)) {
diff --git a/src/kwindowinfo_mac.cpp b/src/kwindowinfo_mac.cpp
index ec4e9bb..c2183ed 100644
--- a/src/kwindowinfo_mac.cpp
+++ b/src/kwindowinfo_mac.cpp
@@ -23,7 +23,9 @@
 #include "kwindowsystem.h"
 
 #include <QDebug>
+#ifndef QT_MAC_USE_COCOA
 #include <kxerrorhandler.h>
+#endif
 #include <netwm.h>
 #include <QBitmap>
 #include <QDesktopWidget>
diff --git a/src/kwindowinfo_mac_p.h b/src/kwindowinfo_mac_p.h
index 26ff790..bb79a6e 100644
--- a/src/kwindowinfo_mac_p.h
+++ b/src/kwindowinfo_mac_p.h
@@ -30,7 +30,7 @@
 #undef check
 #endif
 
-struct KWindowInfo::Private {
+class KWindowInfo::Private {
     Private();
     ~Private();
     int ref;
diff --git a/src/kwindowsystem_mac.cpp b/src/kwindowsystem_mac.cpp
index 2fcec18..122116d 100644
--- a/src/kwindowsystem_mac.cpp
+++ b/src/kwindowsystem_mac.cpp
@@ -22,7 +22,9 @@
 #include "kwindowsystem.h"
 #include "kwindowinfo_mac_p.h"
 
+#ifndef QT_MAC_USE_COCOA
 #include <kxerrorhandler.h>
+#endif
 #include <QBitmap>
 #include <QDesktopWidget>
 #include <QDialog>
@@ -640,4 +642,4 @@ void KWindowSystem::setBlockingCompositing(WId window, bool active)
     qDebug() << "setBlockingCompositing( WId window, bool active ) isn't yet implemented!";
 }
 
-#include "moc_kwindowsystem.cpp"
+#include "kwindowsystem_mac.moc"
