require_relative "../lib/cmake"

class Kf5Kdeclarative < Formula
  desc "Provides integration of QML and KDE Frameworks"
  homepage "https://api.kde.org/frameworks/kdeclarative/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.82/kdeclarative-5.82.0.tar.xz"
  sha256 "5c95ebf424e6d1ffd4da4954e998d8d00ef9f35eb27bfc5779e5c5d9aeaa573f"
  head "https://invent.kde.org/frameworks/kdeclarative.git"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kio"
  depends_on "kde-mac/kde/kf5-kpackage"
  depends_on "libepoxy"

  patch :DATA

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Declarative REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end

# Mark executables as nongui type

__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 51c04dd..f0ef51e 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -48,6 +48,7 @@ include(ECMSetupVersion)
 include(ECMGenerateHeaders)
 include(CMakePackageConfigHelpers)
 include(ECMAddQch)
+include(ECMMarkNonGuiExecutable)
 
 option(BUILD_EXAMPLES "Build and install examples." OFF)
 option(BUILD_QCH "Build API documentation in QCH format (for e.g. Qt Assistant, Qt Creator & KDevelop)" OFF)
diff --git a/src/kpackagelauncherqml/CMakeLists.txt b/src/kpackagelauncherqml/CMakeLists.txt
index 7744b77..b87a5dc 100644
--- a/src/kpackagelauncherqml/CMakeLists.txt
+++ b/src/kpackagelauncherqml/CMakeLists.txt
@@ -18,4 +18,5 @@ target_link_libraries(kpackagelauncherqml
  KF5::QuickAddons
 )
 
+ecm_mark_nongui_executable(kpackagelauncherqml)
 install(TARGETS kpackagelauncherqml ${KDE_INSTALL_TARGETS_DEFAULT_ARGS})
ddiff --git a/src/qmlcontrols/kquickcontrolsaddons/kquickcontrolsaddonsplugin.h b/src/qmlcontrols/kquickcontrolsaddons/kquickcontrolsaddonsplugin.h
index e211526..0511e00 100644
--- a/src/qmlcontrols/kquickcontrolsaddons/kquickcontrolsaddonsplugin.h
+++ b/src/qmlcontrols/kquickcontrolsaddons/kquickcontrolsaddonsplugin.h
@@ -10,7 +10,7 @@
 #define KQUICKCONTROLSADDONSPLUGIN_H

 #include <QQmlExtensionPlugin>
-
+#include <QScreen>

 class KQuickControlsAddonsPlugin : public QQmlExtensionPlugin
 {
