require "formula"

class Kf5Konsole < Formula
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/applications/15.08.1/src/konsole-15.08.1.tar.xz"
  sha1 ""
  head "git://anongit.kde.org/konsole.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"

  depends_on "haraldf/kf5/kf5-kdbusaddons"
  depends_on "haraldf/kf5/kf5-kcoreaddons"
  depends_on "haraldf/kf5/kf5-kconfig"
  depends_on "haraldf/kf5/kf5-kcodecs"
  depends_on "haraldf/kf5/kf5-ki18n"
  depends_on "haraldf/kf5/kf5-kservice"
  depends_on "haraldf/kf5/kf5-kwidgetsaddons"
  depends_on "haraldf/kf5/kf5-kwindowsystem"
  depends_on "haraldf/kf5/kf5-kcrash"
  depends_on "haraldf/kf5/kf5-sonnet"
  depends_on "haraldf/kf5/kf5-karchive"
  depends_on "haraldf/kf5/kf5-kitemmodels"
  depends_on "haraldf/kf5/kf5-kauth"
  depends_on "haraldf/kf5/kf5-kguiaddons"
  depends_on "haraldf/kf5/kf5-kconfigwidgets"
  depends_on "haraldf/kf5/kf5-kitemviews"
  depends_on "haraldf/kf5/kf5-knotifications"
  depends_on "haraldf/kf5/kf5-kjs"
  depends_on "haraldf/kf5/kf5-kpty"
  depends_on "haraldf/kf5/kf5-kjobwidgets"
  depends_on "haraldf/kf5/kf5-kiconthemes"
  depends_on "haraldf/kf5/kf5-kcompletion"
  depends_on "haraldf/kf5/kf5-ktextwidgets"
  depends_on "haraldf/kf5/kf5-kglobalaccel"
  depends_on "haraldf/kf5/kf5-attica"
  depends_on "haraldf/kf5/kf5-kxmlgui"
  depends_on "haraldf/kf5/kf5-solid"
  depends_on "haraldf/kf5/kf5-kwallet"
  depends_on "haraldf/kf5/kf5-kbookmarks"
  depends_on "haraldf/kf5/kf5-kio"
  depends_on "haraldf/kf5/kf5-kunitconversion"
  depends_on "haraldf/kf5/kf5-knotifyconfig"
  depends_on "haraldf/kf5/kf5-kparts"
  depends_on "haraldf/kf5/kf5-kross"
  depends_on "haraldf/kf5/kf5-kinit"
  depends_on "haraldf/kf5/kf5-kdelibs4support"

  def patches
    DATA
  end

  def install
    args = std_cmake_args

    args << "-DCMAKE_INSTALL_BUNDLEDIR=/Applications/KDE"

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end

__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index a3d9a1c..793e586 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -41,6 +41,6 @@ include_directories(${CMAKE_SOURCE_DIR} ${CMAKE_BINARY_DIR} ${KDE4_INCLUDES})
 add_subdirectory( src )
 add_subdirectory( data )
 add_subdirectory( desktop )
-add_subdirectory( doc/manual )
+#add_subdirectory( doc/manual )
 
 feature_summary(WHAT ALL INCLUDE_QUIET_PACKAGES FATAL_ON_MISSING_REQUIRED_PACKAGES)
diff --git a/src/CMakeLists.txt b/src/CMakeLists.txt
index 2ff6f37..86f86e7 100644
--- a/src/CMakeLists.txt
+++ b/src/CMakeLists.txt
@@ -138,6 +138,10 @@ if(${CMAKE_SYSTEM_NAME} MATCHES "FreeBSD")
     #kinfo_getfile() is in libutil
     list(APPEND konsole_LIBS util)
 endif()
+if(APPLE)
+    # OSX still requires kde_file.h
+    list(APPEND konsole_LIBS KF5::KDELibs4Support)
+endif()
 
 ### Konsole Application
 
