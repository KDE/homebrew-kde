require "formula"

class Kio < Formula
  homepage "http://www.kde.org/"
#  url "http://download.kde.org/unstable/frameworks/4.95.0/kio-4.95.0.tar.xz"
#  sha1 ""

  head 'git://anongit.kde.org/kio.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/extra-cmake-modules" => :build
  depends_on "qt5"
  depends_on "haraldf/kf5/kdbusaddons"
  depends_on "haraldf/kf5/kitemviews"
  depends_on "haraldf/kf5/kservice"
  depends_on "haraldf/kf5/kconfigwidgets"
  depends_on "haraldf/kf5/kf5-solid"
  depends_on "haraldf/kf5/kiconthemes"
  depends_on "haraldf/kf5/kcompletion"
  depends_on "haraldf/kf5/kjobwidgets"

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
index 0e67517..f0dafe6 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -40,12 +40,12 @@ if("${CMAKE_BINARY_DIR}" STREQUAL "${CMAKE_CURRENT_BINARY_DIR}")
   find_package(KF5Solid ${KF5_VERSION} REQUIRED)
   find_package(KF5JobWidgets ${KF5_VERSION} REQUIRED)
   find_package(KF5IconThemes ${KF5_VERSION} REQUIRED)
-  find_package(KF5WindowSystem ${KF5_VERSION} REQUIRED)
+# find_package(KF5WindowSystem ${KF5_VERSION} REQUIRED)
   find_package(KF5Crash ${KF5_VERSION} REQUIRED)
   find_package(KF5Completion ${KF5_VERSION} REQUIRED)
-  find_package(KF5DocTools ${KF5_VERSION} REQUIRED)
-  find_package(KF5TextWidgets ${KF5_VERSION} REQUIRED)
-  find_package(KF5XmlGui ${KF5_VERSION} REQUIRED)
+# find_package(KF5DocTools ${KF5_VERSION} REQUIRED)
+#  find_package(KF5TextWidgets ${KF5_VERSION} REQUIRED)
+#  find_package(KF5XmlGui ${KF5_VERSION} REQUIRED)
+#   find_package(KF5Bookmarks ${KF5_VERSION} REQUIRED)
+#   find_package(KF5Notifications ${KF5_VERSION} REQUIRED) #needed for kpac
 else()
