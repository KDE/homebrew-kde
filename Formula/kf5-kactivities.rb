class Kf5Kactivities < Formula
  desc "Core components for the KDE's Activities"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.47/kactivities-5.47.0.tar.xz"
  sha256 "8d61e07a61772491b666a4331e7579a68bdc7a8b0d2fe8d40bff4d0e2a510506"

  head "git://anongit.kde.org/kactivities.git"

  depends_on "cmake" => :build
  depends_on "boost" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "KDE-mac/kde/kf5-kconfig"
  depends_on "KDE-mac/kde/kf5-kcoreaddons"
  depends_on "KDE-mac/kde/kf5-kwindowsystem"

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
index a871ecc..d33094b 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -36,6 +36,7 @@ include (KDECompilerSettings NO_POLICY_SCOPE)
 include (GenerateExportHeader)
 include (ECMGenerateHeaders)
 include (ECMAddQch)
+include (ECMMarkNonGuiExecutable)
 
 option(BUILD_QCH "Build API documentation in QCH format (for e.g. Qt Assistant, Qt Creator & KDevelop)" OFF)
 add_feature_info(QCH ${BUILD_QCH} "API documentation in QCH format (for e.g. Qt Assistant, Qt Creator & KDevelop)")
diff --git a/src/cli/CMakeLists.txt b/src/cli/CMakeLists.txt
index d0e13be..479031b 100644
--- a/src/cli/CMakeLists.txt
+++ b/src/cli/CMakeLists.txt
@@ -30,6 +30,10 @@ target_link_libraries (
    KF5::Activities
    )
 
+ecm_mark_nongui_executable(
+   kactivities-cli
+   )
+
 install (TARGETS
    kactivities-cli
    ${KF5_INSTALL_TARGETS_DEFAULT_ARGS}
