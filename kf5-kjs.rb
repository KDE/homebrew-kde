require "formula"

class Kf5Kjs < Formula
  homepage "http://www.kde.org/"
#  url "http://download.kde.org/unstable/frameworks/4.95.0/kjs-4.95.0.tar.xz"
#  sha1 "6e34a43606295cfcf90a5c87748db97161940c6e"

  head 'git://anongit.kde.org/kjs.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"
  depends_on "pcre"

  def patches
    DATA
  end

  def install
    args = std_cmake_args
    args << "-DCMAKE_PREFIX_PATH=\"#{Formula.factory('qt5').opt_prefix};#{Formula.factory('kf5-extra-cmake-modules').opt_prefix}\""
    args << "-DCMAKE_CXX_FLAGS='-D_DARWIN_C_SOURCE'"

    system "cmake", ".", *args
    system "make", "install"
  end
end

__END__
diff --git a/KF5JSConfig.cmake.in b/KF5JSConfig.cmake.in
index 86a8659..70daf67 100644
--- a/KF5JSConfig.cmake.in
+++ b/KF5JSConfig.cmake.in
@@ -3,6 +3,6 @@
 find_dependency(Qt5Core @REQUIRED_QT_VERSION@)
 
 set(KJS_HAVE_PCRE_REGEX "@PCRE_FOUND@")
-set(KJS_CREATE_HASH_TABLE "${PACKAGE_PREFIX_DIR}/@DATA_INSTALL_DIR@/kjs/create_hash_table")
+set(KJS_CREATE_HASH_TABLE "@DATA_INSTALL_DIR@/kjs/create_hash_table")
 
 include("${CMAKE_CURRENT_LIST_DIR}/KF5JSTargets.cmake")
