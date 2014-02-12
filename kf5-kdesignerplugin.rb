require "formula"

class Kf5Kdesignerplugin < Formula
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kdesignerplugin.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"

  depends_on "haraldf/kf5/kf5-kcoreaddons"

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
index 5fd7acf..2ceaba1 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -22,7 +22,7 @@ set_package_properties(Qt5Designer PROPERTIES
 set(KF5_VERSION "4.96.0")
 find_package(KF5CoreAddons ${KF5_VERSION} REQUIRED)
 find_package(KF5Config ${KF5_VERSION} REQUIRED)
-find_package(KF5DocTools ${KF5_VERSION} REQUIRED)
+#find_package(KF5DocTools ${KF5_VERSION} REQUIRED)
 
 find_package(KF5Completion ${KF5_VERSION})
 set_package_properties(KF5Completion PROPERTIES TYPE OPTIONAL
diff --git a/docs/CMakeLists.txt b/docs/CMakeLists.txt
index 14ac672..730e3dc 100644
--- a/docs/CMakeLists.txt
+++ b/docs/CMakeLists.txt
@@ -1 +1 @@
-add_subdirectory(kgendesignerplugin)
+#add_subdirectory(kgendesignerplugin)
