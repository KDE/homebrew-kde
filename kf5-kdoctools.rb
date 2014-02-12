require "formula"

class Kf5Kdoctools < Formula
  homepage "http://www.kde.org/"
#  url "http://download.kde.org/unstable/frameworks/4.95.0/kdoctools-4.95.0.tar.xz"
#  sha1 ""

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
    args << "-DCMAKE_PREFIX_PATH=\"#{Formula.factory('qt5').opt_prefix};#{Formula.factory('kf5-extra-cmake-modules').opt_prefix};\""
    args << "-DDocBookXML_CURRENTDTD_DIR:PATH=#{Formula.factory('docbook').prefix}/docbook/xml/4.2"
    args << "-DDocBookXSL_DIR:PATH=#{Formula.factory('docbook-xsl').prefix}/docbook-xsl"

    system "cmake", ".", *args
    system "make", "install"
  end
end

__END__
diff --git a/src/CMakeLists.txt b/src/CMakeLists.txt
index 5c82494..17598d6 100644
--- a/src/CMakeLists.txt
+++ b/src/CMakeLists.txt
@@ -146,7 +146,7 @@ add_executable( docbookl10nhelper ${docbookl10nhelper_SRCS} )
 target_link_libraries( docbookl10nhelper Qt5::Core )
 
 add_custom_command( TARGET docbookl10nhelper POST_BUILD
-  COMMAND ${CMAKE_CURRENT_BINARY_DIR}/docbookl10nhelper
+  COMMAND docbookl10nhelper
   ${DOCBOOKXSL_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/customization/xsl
   ${CMAKE_CURRENT_BINARY_DIR}/customization/xsl
 )
