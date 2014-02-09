require "formula"

class Kf5Attica < Formula

  head 'git://anongit.kde.org/attica.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"

  ### the attica vs. Attica doesn't work on Mac due to case-insensitive file system
  def patches
    DATA
  end

  def install
    args = std_cmake_args
    args << "-DCMAKE_PREFIX_PATH=\"#{Formula.factory('qt5').opt_prefix};#{Formula.factory('kf5-extra-cmake-modules').opt_prefix}\""

    system "cmake", ".", *args
    system "make", "install"
  end
end

__END__
diff --git a/src/CMakeLists.txt b/src/CMakeLists.txt
index 676c8a8..0b759fb 100644
--- a/src/CMakeLists.txt
+++ b/src/CMakeLists.txt
@@ -151,10 +151,11 @@ ecm_generate_headers(
   Topic
 
   MODULE_NAME Attica
-  PREFIX Attica
   REQUIRED_HEADERS Attica_HEADERS
 )
-install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/Attica DESTINATION ${INCLUDE_INSTALL_DIR} COMPONENT Devel)
+install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/Attica
+        DESTINATION ${INCLUDE_INSTALL_DIR}
+        COMPONENT Devel)
 
 install(TARGETS KF5Attica
         EXPORT KF5AtticaTargets
@@ -169,7 +170,7 @@ install(FILES
     ${Attica_HEADERS}
     ${CMAKE_CURRENT_BINARY_DIR}/version.h
     ${CMAKE_CURRENT_BINARY_DIR}/atticaclient_export.h
-    DESTINATION ${INCLUDE_INSTALL_DIR}/Attica/attica
+    DESTINATION ${INCLUDE_INSTALL_DIR}/Attica
     COMPONENT Devel
 )
 
