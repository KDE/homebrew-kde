require_relative "../lib/cmake"

class Kf5Kjsembed < Formula
  desc "Embedded JS"
  homepage "https://api.kde.org/frameworks/kjsembed/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.79/portingAids/kjsembed-5.79.0.tar.xz"
  sha256 "fe1694f5ae939f049ba2585112218d1dcbafede6974f486b51619d1a6bc172a2"
  head "https://invent.kde.org/frameworks/kjsembed.git"

  depends_on "cmake" => [:build, :test]
  depends_on "gettext" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "ki18n"
  depends_on "kde-mac/kde/kf5-kjs"

  patch :DATA

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5JsEmbed REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end

# Mark executable as nongui type

__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 8939ba5..1ab9bdc 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -21,6 +21,7 @@ include(GenerateExportHeader)
 include(CMakePackageConfigHelpers)
 include(ECMSetupVersion)
 include(ECMGenerateHeaders)
+include(ECMMarkNonGuiExecutable)
 
 ecm_setup_version(PROJECT VARIABLE_PREFIX KJSEMBED
    #VERSION_HEADER "${CMAKE_CURRENT_BINARY_DIR}/kjsembed_version.h"
diff --git a/src/kjscmd/CMakeLists.txt b/src/kjscmd/CMakeLists.txt
index 95f7c31..16b102f 100644
--- a/src/kjscmd/CMakeLists.txt
+++ b/src/kjscmd/CMakeLists.txt
@@ -10,4 +10,5 @@ target_link_libraries(kjscmd5
     KF5::JsEmbed
 )
 
+ecm_mark_nongui_executable(kjscmd5)
 install(TARGETS kjscmd5 ${KF5_INSTALL_TARGETS_DEFAULT_ARGS})
