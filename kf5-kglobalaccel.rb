require "formula"

class Kf5Kglobalaccel < Formula

  head 'git://anongit.kde.org/kglobalaccel.git'

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
diff --git a/CMakeLists.txt b/CMakeLists.txt
index a797dd0..e60969f 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -26,7 +26,10 @@ include(KDEInstallDirs)
 include(KDEFrameworkCompilerSettings)
 include(KDECMakeSettings)
 
-find_package(X11)
+if (NOT APPLE)
+    find_package(X11)
+endif()
+
 set(HAVE_X11 ${X11_FOUND})
 if(HAVE_X11)
     find_package(Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED X11Extras)
