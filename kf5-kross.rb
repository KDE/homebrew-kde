require "formula"

class Kf5Kross < Formula

  head 'git://anongit.kde.org/kross.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"
  depends_on "haraldf/kf5/kf5-kjs"
  depends_on "haraldf/kf5/kf5-kcompletion"
  depends_on "haraldf/kf5/kf5-ki18n"
  depends_on "haraldf/kf5/kf5-kcoreaddons"
  depends_on "haraldf/kf5/kf5-kauth"
  depends_on "haraldf/kf5/kf5-kcodecs"
  depends_on "haraldf/kf5/kf5-kguiaddons"
  depends_on "haraldf/kf5/kf5-kconfigwidgets"
  depends_on "haraldf/kf5/kf5-kitemviews"
  depends_on "haraldf/kf5/kf5-kiconthemes"
  depends_on "haraldf/kf5/kf5-kglobalaccel"
  depends_on "haraldf/kf5/kf5-kdbusaddons"
  depends_on "haraldf/kf5/kf5-kwindowsystem"
  depends_on "haraldf/kf5/kf5-sonnet"
  depends_on "haraldf/kf5/kf5-ktextwidgets"
  depends_on "haraldf/kf5/kf5-attica"
  depends_on "haraldf/kf5/kf5-kbookmarks"
  depends_on "haraldf/kf5/kf5-kjobwidgets"
  depends_on "haraldf/kf5/kf5-solid"
  depends_on "haraldf/kf5/kf5-kio"
  depends_on "haraldf/kf5/kf5-knotifications"
  depends_on "haraldf/kf5/kf5-kparts"
  depends_on "haraldf/kf5/kf5-kservice"
  depends_on "haraldf/kf5/kf5-kwidgetsaddons"
  depends_on "haraldf/kf5/kf5-kxmlgui"

  ### HACK - disable doctools
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
index 92048da..51438dd 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -25,7 +25,7 @@ set(REQUIRED_QT_VERSION "5.2")
 find_package(Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED Core Script Xml Widgets UiTools)
 
 find_package(KF5Completion ${KF5_VERSION} REQUIRED)
-find_package(KF5DocTools ${KF5_VERSION} REQUIRED)
+#find_package(KF5DocTools ${KF5_VERSION} REQUIRED)
 find_package(KF5I18n ${KF5_VERSION} REQUIRED)
 find_package(KF5IconThemes ${KF5_VERSION} REQUIRED)
 find_package(KF5KIO ${KF5_VERSION} REQUIRED)
diff --git a/docs/kross/CMakeLists.txt b/docs/kross/CMakeLists.txt
index 8e34a07..3d495e7 100644
--- a/docs/kross/CMakeLists.txt
+++ b/docs/kross/CMakeLists.txt
@@ -1 +1 @@
-kdoctools_create_manpage(man-kross.1.docbook 1 INSTALL_DESTINATION ${MAN_INSTALL_DIR})
+#kdoctools_create_manpage(man-kross.1.docbook 1 INSTALL_DESTINATION ${MAN_INSTALL_DIR})
