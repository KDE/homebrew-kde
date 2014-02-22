require "formula"

class Kf5Kcachegrind < Formula
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kcachegrind.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"

  depends_on "haraldf/kf5/kf5-umbrella"
  depends_on "haraldf/kf5/kf5-kcoreaddons"
  depends_on "haraldf/kf5/kf5-kwidgetsaddons"
  depends_on "haraldf/kf5/kf5-kxmlgui"
  depends_on "haraldf/kf5/kf5-kde4support"

  def patches
    DATA
  end

  def install
    args = std_cmake_args
    args << "-DCMAKE_PREFIX_PATH=\"#{Formula.factory('qt5').opt_prefix};#{Formula.factory('kf5-extra-cmake-modules').opt_prefix}\""
    args << "-DCMAKE_CXX_FLAGS='-D_DARWIN_C_SOURCE'"

    system "cmake", ".", *args
    system "make", "install"
  end
end

__END__
commit 4eae950511d80a9002bab7fb7c4d83efedf425ff
Author: Harald Fernengel <harry@kdevelop.org>
Date:   Wed Feb 19 19:30:08 2014 +0100

    First super-hacky port to KF5

diff --git a/CMakeLists.txt b/CMakeLists.txt
index f90ec04..696a013 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -1,14 +1,32 @@
-cmake_minimum_required(VERSION 2.6)
-
 project(kcachegrind)
 
-find_package(KDE4 REQUIRED)
-include(KDE4Defaults)
-include(MacroLibrary)
+cmake_minimum_required (VERSION 2.8.12 FATAL_ERROR)
+
+# minimal requirements
+set (QT_MIN_VERSION "5.2.0")
+
+find_package(ECM 0.0.9 REQUIRED NO_MODULE)
+set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${ECM_MODULE_PATH} ${ECM_KDE_MODULE_DIR})
+
+include(KDEInstallDirs)
+include(KDECMakeSettings)
+include(KDECompilerSettings)
+include(ECMOptionalAddSubdirectory)
+include(ECMInstallIcons)
+include(ECMSetupVersion)
+include(ECMMarkNonGuiExecutable)
+include(ECMGenerateHeaders)
+include(GenerateExportHeader)
+include(FeatureSummary)
 
-set( CMAKE_REQUIRED_DEFINITIONS ${_KDE4_PLATFORM_DEFINITIONS} -DQT_STRICT_ITERATORS )
-add_definitions(${QT_DEFINITIONS} ${KDE4_DEFINITIONS})
-include_directories(${CMAKE_SOURCE_DIR}	${CMAKE_BINARY_DIR} ${KDE4_INCLUDES} )
+find_package(Qt5 ${QT_MIN_VERSION} CONFIG REQUIRED Core DBus Widgets)
+
+find_package(KF5 CONFIG REQUIRED
+    Archive CoreAddons WidgetsAddons XmlGui KDE4Support
+)
+
+add_definitions(-DQT_STRICT_ITERATORS)
+include_directories(${CMAKE_SOURCE_DIR} ${CMAKE_BINARY_DIR} ${KDE4_INCLUDES})
 
 set( KCACHEGRIND_VERSION "0.7.4kde")
 
@@ -19,15 +37,6 @@ IF(NOT WIN32)
   configure_file(${CMAKE_CURRENT_SOURCE_DIR}/kcachegrind.lsm.cmake ${CMAKE_CURRENT_BINARY_DIR}/kcachegrind.lsm )
 ENDIF(NOT WIN32)
 
-macro_additional_clean_files( 
-	${CMAKE_CURRENT_BINARY_DIR}/version.h 
-	)
-IF(NOT WIN32)
-macro_additional_clean_files(
-	${CMAKE_CURRENT_BINARY_DIR}/kcachegrind.lsm 
-	${CMAKE_CURRENT_BINARY_DIR}/kcachegrind.spec
-	)
-ENDIF(NOT WIN32)
 
 add_subdirectory( doc )
 add_subdirectory( libcore )
diff --git a/kcachegrind/CMakeLists.txt b/kcachegrind/CMakeLists.txt
index b94fa38..e6cc2b5 100644
--- a/kcachegrind/CMakeLists.txt
+++ b/kcachegrind/CMakeLists.txt
@@ -9,15 +9,18 @@ set(kcachegrind_SRCS
    configdlg.cpp
    )
 
-kde4_add_ui_files(kcachegrind_SRCS
-        configdlgbase.ui
-	)
+qt5_wrap_ui(kcachegrind_SRCS configdlgbase.ui)
 
 kde4_add_app_icon(kcachegrind_SRCS "${CMAKE_CURRENT_SOURCE_DIR}/hi*-app-kcachegrind.png")
 
 kde4_add_executable(kcachegrind ${kcachegrind_SRCS})
 
-target_link_libraries(kcachegrind core views ${KDE4_KIO_LIBS})
+set(kcachegrind_LIBS
+                 KF5::KDE4Support
+                 KF5::Archive
+)
+
+target_link_libraries(kcachegrind core views ${kcachegrind_LIBS})
 
 install(TARGETS kcachegrind  ${INSTALL_TARGETS_DEFAULT_ARGS} )
 
diff --git a/kcachegrind/configdlg.cpp b/kcachegrind/configdlg.cpp
index 3a3591e..df08593 100644
--- a/kcachegrind/configdlg.cpp
+++ b/kcachegrind/configdlg.cpp
@@ -355,7 +355,7 @@ void ConfigDlg::dirsAddPressed()
     dirs = &(_config->_objectSourceDirs[objName]);
 
   QString newDir;
-  newDir = KFileDialog::getExistingDirectory(KUrl(),
+  newDir = KFileDialog::getExistingDirectory(QUrl(),
                                              this,
                                              i18n("Choose Source Folder"));
   if (newDir.isEmpty()) return;
diff --git a/kcachegrind/main.cpp b/kcachegrind/main.cpp
index e7eafe5..d8e7211 100644
--- a/kcachegrind/main.cpp
+++ b/kcachegrind/main.cpp
@@ -26,8 +26,10 @@
 
 #include <kapplication.h>
 #include <kcmdlineargs.h>
-#include <kaboutdata.h>
+#include <k4aboutdata.h>
 #include <klocale.h>
+#include <kglobal.h>
+#include <kstatusbar.h>
 
 #include "kdeconfig.h"
 #include "toplevel.h"
@@ -36,11 +38,11 @@
 
 int main( int argc, char ** argv )
 {
-  KAboutData aboutData("kcachegrind", 0,
+  K4AboutData aboutData("kcachegrind", 0,
                        ki18n("KCachegrind"),
                        KCACHEGRIND_VERSION,
                        ki18n("KDE Frontend for Callgrind/Cachegrind"),
-                       KAboutData::License_GPL,
+                       K4AboutData::License_GPL,
                        ki18n("(C) 2002 - 2011"), KLocalizedString(),
                        "http://kcachegrind.sf.net");
   aboutData.addAuthor(ki18n("Josef Weidendorfer"),
diff --git a/kcachegrind/toplevel.cpp b/kcachegrind/toplevel.cpp
index 556731d..b7a420f 100644
--- a/kcachegrind/toplevel.cpp
+++ b/kcachegrind/toplevel.cpp
@@ -54,6 +54,7 @@
 #include <kfiledialog.h>
 #include <kio/netaccess.h>
 #include <kedittoolbar.h>
+#include <kshortcut.h>
 #include <kshortcutsdialog.h>
 #include <ktip.h>
 #include <kmenu.h>
@@ -61,7 +62,7 @@
 #include <kdebug.h>
 #include <kicon.h>
 #include <kconfiggroup.h>
-#include <kfilterdev.h>
+#include <KArchive/kfilterdev.h>
 #include <kmimetype.h>
 
 #if ENABLE_DUMPDOCK
@@ -372,7 +373,7 @@ void TopLevel::readProperties(const KConfigGroup &c)
 void TopLevel::createLayoutActions()
 {
   QString hint;
-  KAction* action;
+  QAction* action;
 
   action = actionCollection()->addAction( "layout_duplicate" );
   action->setText( i18n( "&Duplicate" ) );
@@ -420,7 +421,7 @@ void TopLevel::createLayoutActions()
 void TopLevel::createMiscActions()
 {
   QString hint;
-  KAction* action;
+  QAction* action;
 
   action = KStandardAction::openNew(this, SLOT(newWindow()), actionCollection());
   hint = i18n("<b>New</b><p>Open new empty KCachegrind window.</p>");
@@ -456,7 +457,7 @@ void TopLevel::createMiscActions()
   _taDump->setIcon( KIcon("edit-redo") );
   _taDump->setText( i18n( "&Force Dump" ) );
   connect(_taDump, SIGNAL(triggered(bool) ), SLOT( forceTrace() ));
-  _taDump->setShortcut(KStandardShortcut::shortcut(KStandardShortcut::Redo));
+  _taDump->setShortcut(QKeySequence::Undo);
   hint = i18n("<b>Force Dump</b>"
               "<p>This forces a dump for a Callgrind profile run "
               "in the current directory. This action is checked while "
@@ -927,7 +928,13 @@ void TopLevel::load()
     load(url);
 }
 
-void TopLevel::load(const KUrl& url)
+// ### legacy, remove
+void TopLevel::load(const KUrl &url)
+{
+    return load(static_cast<const QUrl &>(url));
+}
+
+void TopLevel::load(const QUrl& url)
 {
   if (url.isEmpty()) return;
 
@@ -943,7 +950,7 @@ void TopLevel::load(const KUrl& url)
   } else {
     KMessageBox::error(this, i18n("Could not open the file \"%1\". "
                                   "Check it exists and you have enough "
-                                  "permissions to read it.", url.prettyUrl()));
+                                  "permissions to read it.", url.toDisplayString()));
   }
 }
 
diff --git a/kcachegrind/toplevel.h b/kcachegrind/toplevel.h
index 3a109ba..1b5e3aa 100644
--- a/kcachegrind/toplevel.h
+++ b/kcachegrind/toplevel.h
@@ -26,6 +26,7 @@
 #include <qdatetime.h>
 #include <QLabel>
 #include <QProcess>
+#include <QUrl>
 
 #include <kxmlguiwindow.h>
 
@@ -45,6 +46,7 @@ class KUrl;
 class KSelectAction;
 class KToggleAction;
 class KToolBarPopupAction;
+class KStatusBar;
 
 class TraceData;
 class KRecentFilesAction;
@@ -96,7 +98,8 @@ public:
 
 public slots:
   void load();
-  void load(const KUrl&);
+  void load(const QUrl&);
+  void load(const KUrl &url); // ### legacy, remove
   void load(QString);
   void add();
   void add(const KUrl&);
@@ -230,7 +233,7 @@ private:
   /// @return true when the file could be opened, false otherwise.
   bool openDataFile(const QString& file);
 
-  KStatusBar* _statusbar;
+  QStatusBar* _statusbar;
   QLabel* _statusLabel;
   KRecentFilesAction* _openRecent;
   bool _twoMainWidgets;
diff --git a/libcore/CMakeLists.txt b/libcore/CMakeLists.txt
index dfbe0f6..4f64bc0 100644
--- a/libcore/CMakeLists.txt
+++ b/libcore/CMakeLists.txt
@@ -16,5 +16,5 @@ set(core_SRCS
    config.cpp
    globalconfig.cpp )
 
-qt4_automoc(${core_SRCS})
+#qt5_automoc(${core_SRCS})
 add_library(core STATIC ${core_SRCS})
diff --git a/libviews/CMakeLists.txt b/libviews/CMakeLists.txt
index 7183f4c..20c3934 100644
--- a/libviews/CMakeLists.txt
+++ b/libviews/CMakeLists.txt
@@ -30,6 +30,6 @@ set(libviews_SRCS
    instritem.cpp
    partlistitem.cpp )
 
-qt4_automoc(${libviews_SRCS})
+#qt4_automoc(${libviews_SRCS})
 add_library(views STATIC ${libviews_SRCS})
 target_link_libraries(views core)
diff --git a/qcachegrind/qtcolorbutton.cpp b/qcachegrind/qtcolorbutton.cpp
index 13a32b0..3279b34 100644
--- a/qcachegrind/qtcolorbutton.cpp
+++ b/qcachegrind/qtcolorbutton.cpp
@@ -266,4 +266,4 @@ void QtColorButton::dropEvent(QDropEvent *event)
 
 QT_END_NAMESPACE
 
-#include "qtcolorbutton.moc"
+#include "moc_qtcolorbutton.cpp"
