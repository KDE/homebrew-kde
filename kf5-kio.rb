require "formula"

class Kf5Kio < Formula
  url "http://download.kde.org/stable/frameworks/5.6/kio-5.6.0.tar.xz"
  sha1 "731a2613a9630656dfc03723505426411d8fdd51"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kio.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"
  depends_on "haraldf/kf5/kf5-karchive"
  depends_on "haraldf/kf5/kf5-kbookmarks"
  depends_on "haraldf/kf5/kf5-kjobwidgets"
  depends_on "haraldf/kf5/kf5-kwallet"
  depends_on "haraldf/kf5/kf5-solid"

  def patches
    DATA
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
diff --git a/CMakeLists.txt b/CMakeLists.txt
index b72d6ee..20bf1c8 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -63,11 +63,6 @@
 set_package_properties(GSSAPI PROPERTIES DESCRIPTION "Allows KIO to make use of
                        TYPE OPTIONAL
                        PURPOSE "A MIT or HEIMDAL flavor of GSSAPI can be used"
                       )
-find_package(X11)
-set(HAVE_X11 ${X11_FOUND})
-if (HAVE_X11)
-    find_package(Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED X11Extras)
-endif()

 add_definitions(-DTRANSLATION_DOMAIN=\"kio5\")
 if (IS_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/po")
