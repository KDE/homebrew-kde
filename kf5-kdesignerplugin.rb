require "formula"

class Kf5Kdesignerplugin < Formula
  url "http://download.kde.org/stable/frameworks/5.14/kdesignerplugin-5.14.0.tar.xz"
  sha1 "051beaf550169f44058fcf5bf638f41be1728b19"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kdesignerplugin.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kdoctools" => :build
  depends_on "haraldf/kf5/kf5-kdewebkit"
  depends_on "haraldf/kf5/kf5-kplotting"
  depends_on "qt5" => "with-d-bus"

  def patches
    DATA
  end

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end

__END__
commit 6cbf534c3cd2c5bdda819e092c9778c27e814161
Author: Kurt Hindenburg <kurt.hindenburg@gmail.com>
Date:   Wed Sep 16 06:15:52 2015 -0700

    Qt moc can't handle macros (QT_VERSION_CHECK)
    
    Fix build by removing macro and using hard-coded version.  Tested with
    Qt 5.4.x
    
    OK per David Faure

diff --git a/src/kgendesignerplugin.cpp b/src/kgendesignerplugin.cpp
index bc4de47..a2c3869 100644
--- a/src/kgendesignerplugin.cpp
+++ b/src/kgendesignerplugin.cpp
@@ -21,7 +21,7 @@ static const char classHeader[] =   "/**\n"
                                     "*/\n"
                                     "#include <QIcon>\n"
                                     "#include <QtDesigner/QDesignerContainerExtension>\n"
-                                    "#if QT_VERSION >= QT_VERSION_CHECK(5, 5, 0)\n"
+                                    "#if QT_VERSION >= 0x050500\n"
                                     "# include <QtUiPlugin/QDesignerCustomWidgetInterface>\n"
                                     "#else\n"
                                     "# include <QDesignerCustomWidgetInterface>\n"
commit 8669cfd5f9527f0e8584caf93a758e10102690e1
Author: Harald Fernengel <harald.fernengel@here.com>
Date:   Fri Sep 25 14:04:24 2015 +0300

    Fix build on Mac OS X

    Qt 5.5 requires Qt5UiPlugin framework to be in the include path.
    On Linux this didn't break as all Qt headers are typically in the
    same prefix, but on Mac, the include hierarchy is quite different.

diff --git a/KF5DesignerPluginMacros.cmake b/KF5DesignerPluginMacros.cmake
index 15db23d..0dfa9cd 100644
--- a/KF5DesignerPluginMacros.cmake
+++ b/KF5DesignerPluginMacros.cmake
@@ -87,9 +87,22 @@ macro(kf5designerplugin_add_plugin target)
             PURPOSE "Required to build Qt Designer plugins"
         )
     endif()
+    if(NOT Qt5Designer_VERSION_STRING VERSION_LESS 5.5.0 AND NOT Qt5UiPlugin_FOUND)
+        find_package(Qt5UiPlugin ${REQUIRED_QT_VERSION} ${_requiredarg} NO_MODULE)
+        set_package_properties(Qt5UiPlugin PROPERTIES
+            PURPOSE "Required to build Qt Designer plugins"
+        )
+    endif()
+    if (Qt5UiPlugin_FOUND)
+        # for some reason, Qt5UiPlugin does not set its _INCLUDE_DIRS variable. Fill it manually
+        get_target_property(Qt5UiPlugin_INCLUDE_DIRS Qt5::UiPlugin INTERFACE_INCLUDE_DIRECTORIES)
+    endif()
     if(Qt5Designer_FOUND)
         add_library(${target} MODULE ${_files})
-        target_include_directories(${target} PRIVATE ${Qt5Designer_INCLUDE_DIRS})
+        target_include_directories(${target}
+             PRIVATE ${Qt5UiPlugin_INCLUDE_DIRS}
+             PRIVATE ${Qt5Designer_INCLUDE_DIRS}
+        )
     endif()
 endmacro()
 
