require "formula"

class Kf5Kdoctools < Formula
  url "http://download.kde.org/unstable/frameworks/4.97.0/kdoctools-4.97.0.tar.xz"
  sha1 "f13163daf56d13bf1d66bbde8259002e3d42bf38"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kdoctools.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"
  depends_on "docbook"
  depends_on "docbook-xsl"

  def patches
    DATA
  end

  def install
    args = std_cmake_args

    args << "-DDocBookXML_CURRENTDTD_DIR:PATH=#{Formula.factory('docbook').prefix}/docbook/xml/4.2"
    args << "-DDocBookXSL_DIR:PATH=#{Formula.factory('docbook-xsl').prefix}/docbook-xsl"

    system "cmake", ".", *args
    system "make", "install"
  end
end

__END__
diff --git a/KF5DocToolsConfig.cmake.in b/KF5DocToolsConfig.cmake.in
index 7ae030e..59e53c2 100644
--- a/KF5DocToolsConfig.cmake.in
+++ b/KF5DocToolsConfig.cmake.in
@@ -1,6 +1,10 @@
 @PACKAGE_INIT@
 
-set(KDOCTOOLS_DATA_INSTALL_DIR "${PACKAGE_PREFIX_DIR}/@DATA_INSTALL_DIR@")
+if (APPLE)
+    set(KDOCTOOLS_DATA_INSTALL_DIR "@DATA_INSTALL_DIR@")
+else()
+    set(KDOCTOOLS_DATA_INSTALL_DIR "${PACKAGE_PREFIX_DIR}/@DATA_INSTALL_DIR@")
+endif()
 set(KDOCTOOLS_CUSTOMIZATION_DIR "${KDOCTOOLS_DATA_INSTALL_DIR}/kdoctools5/customization")
 
 include("${CMAKE_CURRENT_LIST_DIR}/KF5DocToolsTargets.cmake")
diff --git a/cmake/FindDocBookXML4.cmake b/cmake/FindDocBookXML4.cmake
index eb4bfd8..bac1fbb 100644
--- a/cmake/FindDocBookXML4.cmake
+++ b/cmake/FindDocBookXML4.cmake
@@ -34,6 +34,7 @@ function (locate_version version found_dir)
         share/xml/docbook/xml-dtd-${version}
         share/sgml/docbook/xml-dtd-${version}
         share/xml/docbook/${version}
+        opt/docbook/docbook/xml/${version}
     )
 
     find_path (searched_dir docbookx.dtd
