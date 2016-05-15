require "formula"

class Kf5Kjs < Formula
  url "http://download.kde.org/stable/frameworks/5.22/portingAids/kjs-5.22.0.tar.xz"
  sha1 "fc577a10d6d2f346f16583bc706baa23edd5d42f"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kjs.git'

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kdoctools" => :build
  depends_on "qt5" => "with-dbus"
  depends_on "pcre"

#  def patches
#    DATA
#  end

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
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
