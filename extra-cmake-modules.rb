require "formula"

class ExtraCmakeModules < Formula
  homepage "http://www.kde.org/"
  url "http://download.kde.org/unstable/frameworks/4.95.0/extra-cmake-modules-0.0.9.tar.xz"
  sha1 "dcdf6240b9fd7f1e6be390435f5aa70d804c914a"

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
