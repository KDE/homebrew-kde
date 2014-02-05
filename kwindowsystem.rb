require "formula"

class Kwindowsystem < Formula
  homepage "http://www.kde.org/"
  url "http://download.kde.org/unstable/frameworks/4.95.0/kwindowsystem-4.95.0.tar.xz"
  sha1 ""

  head 'git://anongit.kde.org/kwindowsystem.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/extra-cmake-modules" => :build
  depends_on "qt5"

  def patches
    DATA
  end

  def install
    args = std_cmake_args
    args << "-DCMAKE_PREFIX_PATH=\"#{Formula.factory('qt5').opt_prefix};#{Formula.factory('extra-cmake-modules').opt_prefix}\""
    args << "-DCMAKE_CXX_FLAGS='-D_DARWIN_C_SOURCE -DQT_MAC_USE_COCOA'"

    system "cmake", ".", *args
    system "make", "install"
  end
end

__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 7e497ec..c4f2880 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -26,14 +26,10 @@ include(KDEInstallDirs)
 include(KDEFrameworkCompilerSettings)
 include(KDECMakeSettings)
 
-if(NOT WIN32)
+if(NOT WIN32 AND NOT APPLE)
     find_package(Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED X11Extras)
 endif()
 
-if (APPLE)
-   find_package(Carbon REQUIRED)
-endif ()
-
 if(WIN32)
    find_package(Qt5WinExtras REQUIRED)
 endif()
diff --git a/src/kwindowsystem_mac.cpp b/src/kwindowsystem_mac.cpp
index d20fbbb..ebb0cdb 100644
--- a/src/kwindowsystem_mac.cpp
+++ b/src/kwindowsystem_mac.cpp
@@ -640,4 +640,4 @@ void KWindowSystem::setBlockingCompositing(WId window, bool active)
     qDebug() << "setBlockingCompositing( WId window, bool active ) isn't yet implemented!";
 }
 
-#include "moc_kwindowsystem.cpp"
+#include "kwindowsystem_mac.moc"
