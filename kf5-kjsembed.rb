require "formula"

class Kf5Kjsembed < Formula
  version "5.39.0"
  url "https://download.kde.org/stable/frameworks/#{version}/kjsembed-#{version}.tar.xz"
  sha256 "ebcd97eaa6a5e36f6af7201e10f716aaab3a8cda984ce6b115a8274072f778c4"
  desc "Embedded JS"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/attica.git"

  depends_on "cmake" => :build
  depends_on "gettext" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build

  depends_on "qt"
  depends_on "KDE-mac/kde/kf5-ki18n"
  depends_on "KDE-mac/kde/kf5-kjs"

  patch :DATA

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end

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
 install(TARGETS kjscmd5 EXPORT KF5JsEmbedTargets ${KF5_INSTALL_TARGETS_DEFAULT_ARGS})
