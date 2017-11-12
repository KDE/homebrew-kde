class Kf5Kross < Formula
  url "https://download.kde.org/stable/frameworks/5.40/portingAids/kross-5.40.0.tar.xz"
  sha256 "17a570e2e742e06dc6b28e8610fc1795312be960938ce25acf480005f5d409f9"
  desc "Multi-language application scripting"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kross.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build

  depends_on "qt"
  depends_on "KDE-mac/kde/kf5-kparts"

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
index 1bf53a0..45ad3d3 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -20,6 +20,8 @@ include(ECMGenerateHeaders)
 
 include(ECMQtDeclareLoggingCategory)
 
+include(ECMMarkNonGuiExecutable)
+
 include(KDEInstallDirs)
 include(KDEFrameworkCompilerSettings NO_POLICY_SCOPE)
 include(KDECMakeSettings)
diff --git a/src/console/CMakeLists.txt b/src/console/CMakeLists.txt
index 8e15a1a..6808f52 100644
--- a/src/console/CMakeLists.txt
+++ b/src/console/CMakeLists.txt
@@ -7,4 +7,5 @@ target_link_libraries(kf5kross
    Qt5::Widgets
 )
 
+ecm_mark_nongui_executable(kf5kross)
 install(TARGETS kf5kross ${KF5_INSTALL_TARGETS_DEFAULT_ARGS})

