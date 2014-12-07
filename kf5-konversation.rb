require "formula"

class Kf5Konversation < Formula
  homepage "http://www.kde.org/"

  url "http://download.kde.org/unstable/konversation/1.6-beta1/src/konversation-1.6-beta1.tar.xz"
  sha1 "564bdc092cbdce1c0a9cf1e5362d4956c059c6f3"
  head "git://anongit.kde.org/konversation.git", :branch => "master"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"
  depends_on "qca" => :optional # must built with qt5

  depends_on "haraldf/kf5/kf5-karchive"
  depends_on "haraldf/kf5/kf5-kbookmarks"
  depends_on "haraldf/kf5/kf5-kconfig"
  depends_on "haraldf/kf5/kf5-kconfigwidgets"
  depends_on "haraldf/kf5/kf5-kdoctools"
  depends_on "haraldf/kf5/kf5-kemoticons"
  depends_on "haraldf/kf5/kf5-ki18n"
  depends_on "haraldf/kf5/kf5-kidletime"
  depends_on "haraldf/kf5/kf5-knotifyconfig"
  depends_on "haraldf/kf5/kf5-kdelibs4support"
  depends_on "haraldf/kf5/kf5-kio"
  depends_on "haraldf/kf5/kf5-kparts"
  depends_on "haraldf/kf5/kf5-solid"
  depends_on "haraldf/kf5/kf5-sonnet"
  depends_on "haraldf/kf5/kf5-kwallet"
  depends_on "haraldf/kf5/kf5-kwidgetsaddons"
  depends_on "haraldf/kf5/kf5-kglobalaccel"

 # def patches
 #   DATA
 # end

  def install
    args = std_cmake_args

    args << "-DCMAKE_CXX_FLAGS='-D_DARWIN_C_SOURCE'"

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end

__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index e25a4b7..98258c0 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -91,7 +91,7 @@ add_definitions(
 
 # helper libs
 add_subdirectory( libs )
-add_subdirectory( doc )
+#add_subdirectory( doc )
 
 set( OKTETALIBS_MAJOR_VERSION 0 )
 set( OKTETALIBS_MINOR_VERSION 9 )
