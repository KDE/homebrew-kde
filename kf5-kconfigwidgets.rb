require "formula"

class Kf5Kconfigwidgets < Formula
  homepage "http://www.kde.org/"
#  url "http://download.kde.org/unstable/frameworks/4.95.0/kconfigwidgets-4.95.0.tar.xz"
#  sha1 ""

  head 'git://anongit.kde.org/kconfigwidgets.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5"
  depends_on "haraldf/kf5/kf5-kauth"
  depends_on "haraldf/kf5/kf5-kcodecs"
  depends_on "haraldf/kf5/kf5-kconfig"
  depends_on "haraldf/kf5/kf5-kguiaddons"
  depends_on "haraldf/kf5/kf5-kwidgetsaddons"
  depends_on "haraldf/kf5/kf5-ki18n"

### hack - disable doctools als they are too fat
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
index b5b42fb..6343868 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -26,7 +26,7 @@ if(NOT kdelibs_SOURCE_DIR)
   find_package(KF5CoreAddons ${KF5_VERSION} REQUIRED)
   find_package(KF5Codecs ${KF5_VERSION} REQUIRED)
   find_package(KF5Config ${KF5_VERSION} REQUIRED)
-  find_package(KF5DocTools ${KF5_VERSION} REQUIRED)
+# find_package(KF5DocTools ${KF5_VERSION} REQUIRED)
   find_package(KF5GuiAddons ${KF5_VERSION} REQUIRED)
   find_package(KF5I18n ${KF5_VERSION} REQUIRED)
   find_package(KF5WidgetsAddons ${KF5_VERSION} REQUIRED)
diff --git a/docs/preparetips/CMakeLists.txt b/docs/preparetips/CMakeLists.txt
index 1ab2dbe..c47dd8a 100644
--- a/docs/preparetips/CMakeLists.txt
+++ b/docs/preparetips/CMakeLists.txt
@@ -1 +1 @@
-kdoctools_create_manpage(man-preparetips5.1.docbook 1 INSTALL_DESTINATION ${MAN_INSTALL_DIR})
+#kdoctools_create_manpage(man-preparetips5.1.docbook 1 INSTALL_DESTINATION ${MAN_INSTALL_DIR})
