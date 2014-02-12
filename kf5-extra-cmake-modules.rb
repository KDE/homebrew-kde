require "formula"

class Kf5ExtraCmakeModules < Formula
  homepage "http://www.kde.org/"
#  url "http://download.kde.org/unstable/frameworks/4.95.0/extra-cmake-modules-0.0.9.tar.xz"
#  sha1 "dcdf6240b9fd7f1e6be390435f5aa70d804c914a"

  keg_only "Only required for building KDE frameworks"

  head 'git://anongit.kde.org/extra-cmake-modules'

  depends_on "cmake" => :build

  def patches
    DATA
  end

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end
end

__END__
diff --git a/modules/ECMGenerateHeaders.cmake b/modules/ECMGenerateHeaders.cmake
index e98a22e91151d23d7c798ff22a33097ec2a59d10..f296339137e82e8f719db0ac0d249af02143eca9 100644
--- a/modules/ECMGenerateHeaders.cmake
+++ b/modules/ECMGenerateHeaders.cmake
@@ -76,7 +76,7 @@ function(ECM_GENERATE_HEADERS)
         if (EGH_PREFIX)
             #local forwarding header, for namespaced headers, e.g. kparts/part.h
             #this should not get installed, so we don't put it under EGH_MODULE_NAME
-            set(REGULAR_HEADER_NAME ${EGH_OUTPUT_DIR}/${lowercaseprefix}${lowercaseclassname}.h)
+            set(REGULAR_HEADER_NAME ${EGH_OUTPUT_DIR}/local/${lowercaseprefix}${lowercaseclassname}.h)
             if (NOT EXISTS ${REGULAR_HEADER_NAME})
                 file(WRITE ${REGULAR_HEADER_NAME} "#include \"${_actualheader}\"\n")
             endif()
diff --git a/kde-modules/KDECompilerSettings.cmake b/kde-modules/KDECompilerSettings.cmake
index 335e127..3b546c5 100644
--- a/kde-modules/KDECompilerSettings.cmake
+++ b/kde-modules/KDECompilerSettings.cmake
@@ -273,7 +273,7 @@ endfunction()
 ############################################################
 
 if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU" OR
-        "${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang" OR
+        ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang" AND NOT APPLE) OR
         ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Intel" AND NOT WIN32))
     # Linker warnings should be treated as errors
     set(CMAKE_SHARED_LINKER_FLAGS "-Wl,--fatal-warnings ${CMAKE_SHARED_LINKER_FLAGS}")
