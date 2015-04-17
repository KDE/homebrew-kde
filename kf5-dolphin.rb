require "formula"

class Kf5Dolphin < Formula
  homepage "http://www.kde.org/"
  head "git://anongit.kde.org/dolphin.git", :branch => "frameworks"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"

  depends_on "haraldf/kf5/kf5-kactivities"
  depends_on "haraldf/kf5/kf5-karchive"
  depends_on "haraldf/kf5/kf5-kbookmarks"
  depends_on "haraldf/kf5/kf5-kcmutils"
  depends_on "haraldf/kf5/kf5-kcoreaddons"
  depends_on "haraldf/kf5/kf5-kconfig"
  depends_on "haraldf/kf5/kf5-kconfigwidgets"
  depends_on "haraldf/kf5/kf5-kdbusaddons"
  depends_on "haraldf/kf5/kf5-kdoctools"
  depends_on "haraldf/kf5/kf5-kinit"
  depends_on "haraldf/kf5/kf5-kio"
  depends_on "haraldf/kf5/kf5-knewstuff"
  depends_on "haraldf/kf5/kf5-kdelibs4support"
  depends_on "haraldf/kf5/kf5-kparts"
  depends_on "haraldf/kf5/kf5-kdesu"

  def patches
    DATA
  end

  def install
    args = std_cmake_args

    args << "-DCMAKE_CXX_FLAGS='-D_DARWIN_C_SOURCE'"
    args << "-DCMAKE_INSTALL_BUNDLEDIR=/Applications/KDE"

    system "cmake", ".", *args
    cd "dolphin" do
      system "make", "install"
    end
    cd "lib" do
      system "make", "install"
    end
  end
end
__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index f925f60..e0f1d97 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -41,14 +41,14 @@ add_subdirectory(lib)
 add_subdirectory(kioslave/about)
 add_subdirectory(dolphin)
 add_subdirectory(kdialog)
-add_subdirectory(doc)
+#add_subdirectory(doc)
 if(NOT WIN32)
     add_subdirectory(kdepasswd)
 endif()
 add_subdirectory(kfind)
 
-add_subdirectory( keditbookmarks )
-add_subdirectory(konqueror)
+#add_subdirectory( keditbookmarks )
+#add_subdirectory(konqueror)
 # add_subdirectory( konq-plugins )
 # if ( Q_WS_X11 )
 #   add_subdirectory( nsplugins )
diff --git a/dolphin/CMakeLists.txt b/dolphin/CMakeLists.txt
index 43e3807..c3c448f 100644
--- a/dolphin/CMakeLists.txt
+++ b/dolphin/CMakeLists.txt
@@ -55,7 +55,7 @@ if (KF5Baloo_FOUND AND KF5BalooWidgets_FOUND AND KF5FileMetaData_FOUND)
 endif()
 
 add_subdirectory(src)
-add_subdirectory(docs)
+#add_subdirectory(docs)
 
 # TODO Remove the if/endif lines if Dolphin is split.
 if ("${CMAKE_SOURCE_DIR}" STREQUAL "${Dolphin_SOURCE_DIR}")