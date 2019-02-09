class Kf5Kdeclarative < Formula
  desc "Provides integration of QML and KDE Frameworks"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.55/kdeclarative-5.55.0.tar.xz"
  sha256 "aa51a98e66dcfeb08d26cc79b230fac3eac9235a5d3dee08805cf964f3a17210"

  head "git://anongit.kde.org/kdeclarative.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "KDE-mac/kde/kf5-kio"
  depends_on "KDE-mac/kde/kf5-kpackage"
  depends_on "libepoxy"

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
 install(TARGETS kpackagelauncherqml ${INSTALL_TARGETS_DEFAULT_ARGS})
