require "formula"

class Kf5Kactivities < Formula
  desc "Core components for the KDE's Activities"
  homepage "http://www.kde.org/"
  url "https://download.kde.org/stable/frameworks/5.39/kactivities-5.39.0.tar.xz"
  sha256 "986a0d40de1ae857639c8b2717a4cfc37288c0b7152bb3225b7e7b63cf0d6c5a"

  head "git://anongit.kde.org/kactivities.git"

  depends_on "cmake" => :build
  depends_on "boost" => :build
  depends_on "doxygen" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "qt"
  depends_on "KDE-mac/kde/kf5-kconfig"
  depends_on "KDE-mac/kde/kf5-kdeclarative"
  depends_on "KDE-mac/kde/kf5-kdbusaddons"
  depends_on "KDE-mac/kde/kf5-ki18n"
  depends_on "KDE-mac/kde/kf5-kcmutils"

  patch :DATA

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DQML_INSTALL_DIR=lib/qt5/qml"

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
