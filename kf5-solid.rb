require "formula"

class Kf5Solid < Formula
  homepage "http://www.kde.org/"
#  url "http://download.kde.org/unstable/frameworks/4.95.0/solid-4.95.0.tar.xz"
#  sha1 ""

  head 'git://anongit.kde.org/solid.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5"

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
diff --git a/src/solid/CMakeLists.txt b/src/solid/CMakeLists.txt
index b23aa6c..e6da040 100644
--- a/src/solid/CMakeLists.txt
+++ b/src/solid/CMakeLists.txt
@@ -502,7 +502,6 @@ ecm_generate_headers(
 
   MODULE_NAME Solid
   REQUIRED_HEADERS Solid_HEADERS
-  PREFIX Solid
 )
 install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/Solid DESTINATION ${INCLUDE_INSTALL_DIR} COMPONENT Devel)
 
@@ -536,7 +535,7 @@ install(FILES
   ${CMAKE_CURRENT_BINARY_DIR}/solid_export.h
   ${Solid_HEADERS}
   solidnamespace.h
-  DESTINATION ${INCLUDE_INSTALL_DIR}/Solid/solid COMPONENT Devel
+  DESTINATION ${INCLUDE_INSTALL_DIR}/Solid COMPONENT Devel
 )
 
 ########### parser build ###############

