require "formula"

class Kf5Kunitconversion < Formula
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kunitconversion.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"
  depends_on "haraldf/kf5/kf5-kjs"
  depends_on "haraldf/kf5/kf5-ki18n"
  depends_on "haraldf/kf5/kf5-kconfig"

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
diff --git a/src/CMakeLists.txt b/src/CMakeLists.txt
index c459500..27ae179 100644
--- a/src/CMakeLists.txt
+++ b/src/CMakeLists.txt
@@ -33,7 +33,7 @@ if (MSVC)
 endif()
 generate_export_header(KF5UnitConversion BASE_NAME KUnitConversion EXPORT_FILE_NAME ${CMAKE_CURRENT_BINARY_DIR}/kunitconversion/kunitconversion_export.h)
 add_library(KF5::UnitConversion ALIAS KF5UnitConversion)
-target_include_directories(KF5UnitConversion PUBLIC "$<BUILD_INTERFACE:${KUnitConversion_BINARY_DIR}>")
+target_include_directories(KF5UnitConversion PUBLIC "$<BUILD_INTERFACE:${KUnitConversion_BINARY_DIR};${CMAKE_CURRENT_BINARY_DIR}/local>")
 target_include_directories(KF5UnitConversion INTERFACE "$<INSTALL_INTERFACE:${INCLUDE_INSTALL_DIR}>/KUnitConversion")
 
 target_link_libraries(KF5UnitConversion PUBLIC  Qt5::Core
