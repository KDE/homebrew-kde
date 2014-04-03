require "formula"

class Kf5Kio < Formula
  url "http://download.kde.org/unstable/frameworks/4.97.0/kio-4.97.0.tar.xz"
  sha1 "84c40160cfbd855d0808911a6afd40e4efd2dc2f"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kio.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"
  depends_on "haraldf/kf5/kf5-kdbusaddons"
  depends_on "haraldf/kf5/kf5-kdoctools"
  depends_on "haraldf/kf5/kf5-kitemviews"
  depends_on "haraldf/kf5/kf5-kservice"
  depends_on "haraldf/kf5/kf5-kconfigwidgets"
  depends_on "haraldf/kf5/kf5-solid"
  depends_on "haraldf/kf5/kf5-kiconthemes"
  depends_on "haraldf/kf5/kf5-kcompletion"
  depends_on "haraldf/kf5/kf5-kjobwidgets"
  depends_on "haraldf/kf5/kf5-knotifications"
  depends_on "haraldf/kf5/kf5-kbookmarks"

  def patches
    if not build.head?
      DATA
    end
  end

  def install
    args = std_cmake_args
    args << "-DCMAKE_CXX_FLAGS='-D_DARWIN_C_SOURCE'"
    args << "-DCMAKE_C_FLAGS='-D_DARWIN_C_SOURCE'"
    args << "-DCMAKE_REQUIRED_DEFINITIONS='-D_DARWIN_C_SOURCE'"

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end

__END__
diff --git a/src/CMakeLists.txt b/src/CMakeLists.txt
index e39742e..bbb38cf 100644
--- a/src/CMakeLists.txt
+++ b/src/CMakeLists.txt
@@ -6,7 +6,7 @@ add_subdirectory(ioslaves)
 add_subdirectory(kssld)
 add_subdirectory(kioslave)
 
-if(NOT WIN32)
+if(NOT WIN32 AND NOT APPLE)
   # arpa/nameser.h
   add_subdirectory(kpac)
 endif()
diff --git a/src/core/kmountpoint.cpp b/src/core/kmountpoint.cpp
index cc69957..3d568f8 100644
--- a/src/core/kmountpoint.cpp
+++ b/src/core/kmountpoint.cpp
@@ -51,6 +51,12 @@ static Qt::CaseSensitivity cs = Qt::CaseSensitive;
 #include <sys/mntent.h>
 #endif
 
+#ifdef Q_OS_MAC
+#  define HAVE_SYS_MOUNT_H 1
+#  define HAVE_SYS_TYPES_H 1
+#  define HAVE_SYS_PARAM_H 1
+#endif
+
 // This is the *BSD branch
 #if HAVE_SYS_MOUNT_H
 #if HAVE_SYS_TYPES_H
diff --git a/tests/udsentrybenchmark.cpp b/tests/udsentrybenchmark.cpp
index 75fc758..99caf25 100644
--- a/tests/udsentrybenchmark.cpp
+++ b/tests/udsentrybenchmark.cpp
@@ -243,7 +243,9 @@ void UDSEntryBenchmark::saveLargeEntries()
     }
 }
 
-bool operator==(const KIO::UDSEntry &a, const KIO::UDSEntry &b)
+namespace KIO
+{
+bool operator==(const UDSEntry &a, const UDSEntry &b)
 {
     if (a.count() != b.count()) {
         return false;
@@ -268,6 +270,7 @@ bool operator==(const KIO::UDSEntry &a, const KIO::UDSEntry &b)
 
     return true;
 }
+}
 
 void UDSEntryBenchmark::loadSmallEntries()
 {
