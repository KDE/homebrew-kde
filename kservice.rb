require "formula"

class Kservice < Formula
  homepage "http://www.kde.org/"
#  url "http://download.kde.org/unstable/frameworks/4.95.0/kservice-4.95.0.tar.xz"
#  sha1 ""

  head 'git://anongit.kde.org/kservice.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/extra-cmake-modules" => :build
  depends_on "qt5"
  depends_on "haraldf/kf5/kcrash"

  def patches
    DATA
  end

  def install
    args = std_cmake_args
    args << "-DCMAKE_PREFIX_PATH=\"#{Formula.factory('qt5').opt_prefix};#{Formula.factory('extra-cmake-modules').opt_prefix}\""

    system "cmake", ".", *args
    system "make", "install"
  end
end

__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 2b939fa..e5cb40c 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -36,11 +36,11 @@ if("${CMAKE_BINARY_DIR}" STREQUAL "${CMAKE_CURRENT_BINARY_DIR}")
   find_package(KF5Crash ${KF5_VERSION} REQUIRED)
   find_package(KF5DBusAddons ${KF5_VERSION} REQUIRED)
   find_package(KF5I18n ${KF5_VERSION} REQUIRED)
-  find_package(KF5DocTools REQUIRED)
+#  find_package(KF5DocTools REQUIRED)
 else()
     set(_kdeBootStrapping TRUE)
-    include(${CMAKE_SOURCE_DIR}/tier2/kdoctools/KF5DocToolsMacros.cmake)
-    set(KDOCTOOLS_CUSTOMIZATION_DIR "${KDocTools_BINARY_DIR}/src/customization/")
+    #include(${CMAKE_SOURCE_DIR}/tier2/kdoctools/KF5DocToolsMacros.cmake)
+    #set(KDOCTOOLS_CUSTOMIZATION_DIR "${KDocTools_BINARY_DIR}/src/customization/")
 endif()
 
 # create a Config.cmake and a ConfigVersion.cmake file and install them
diff --git a/docs/desktoptojson/CMakeLists.txt b/docs/desktoptojson/CMakeLists.txt
index 6fecff6..612fc98 100644
--- a/docs/desktoptojson/CMakeLists.txt
+++ b/docs/desktoptojson/CMakeLists.txt
@@ -1 +1 @@
-kdoctools_create_manpage(man-desktoptojson.8.docbook 8 INSTALL_DESTINATION ${MAN_INSTALL_DIR})
+#kdoctools_create_manpage(man-desktoptojson.8.docbook 8 INSTALL_DESTINATION ${MAN_INSTALL_DIR})
diff --git a/docs/kbuildsycoca5/CMakeLists.txt b/docs/kbuildsycoca5/CMakeLists.txt
index 5b7270c..cdb7b17 100644
--- a/docs/kbuildsycoca5/CMakeLists.txt
+++ b/docs/kbuildsycoca5/CMakeLists.txt
@@ -1 +1 @@
-kdoctools_create_manpage(man-kbuildsycoca5.8.docbook 8 INSTALL_DESTINATION ${MAN_INSTALL_DIR})
+#kdoctools_create_manpage(man-kbuildsycoca5.8.docbook 8 INSTALL_DESTINATION ${MAN_INSTALL_DIR})
diff --git a/docs/kdeinit5/CMakeLists.txt b/docs/kdeinit5/CMakeLists.txt
index f61c2be..d415583 100644
--- a/docs/kdeinit5/CMakeLists.txt
+++ b/docs/kdeinit5/CMakeLists.txt
@@ -1 +1 @@
-kdoctools_create_manpage(man-kdeinit5.8.docbook 8 INSTALL_DESTINATION ${MAN_INSTALL_DIR})
+#kdoctools_create_manpage(man-kdeinit5.8.docbook 8 INSTALL_DESTINATION ${MAN_INSTALL_DIR})
