require "formula"

class Kf5Kwallet < Formula
  version "5.39.0"
  url "https://download.kde.org/stable/frameworks/#{version}/kwallet-#{version}.tar.xz"
  sha256 "5f83a5ca245773abfe5b31c536996ca1aee312d512181d133edcd890874f9fee"
  desc "Secure and unified container for user passwords"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kwallet.git"

  depends_on "cmake" => :build
  depends_on "boost" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "gettext" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build

  depends_on "qt"
  depends_on "libgcrypt"
  depends_on "gpgme"
  depends_on "KDE-mac/kde/kf5-knotifications"
  depends_on "KDE-mac/kde/kf5-kiconthemes"
  depends_on "KDE-mac/kde/kf5-kservice"

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
index 216f340..1128b80 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -21,6 +21,7 @@ include(KDECMakeSettings)
 
 include(ECMAddQch)
 include(ECMSetupVersion)
+include(ECMMarkNonGuiExecutable)
 
 option(BUILD_KWALLETD "Build the kwallet daemon" ON)
 option(BUILD_KWALLET_QUERY "Build kwallet-query tool" ON)
diff --git a/src/runtime/kwallet-query/src/CMakeLists.txt b/src/runtime/kwallet-query/src/CMakeLists.txt
index 9aa167b..9a98eb4 100644
--- a/src/runtime/kwallet-query/src/CMakeLists.txt
+++ b/src/runtime/kwallet-query/src/CMakeLists.txt
@@ -12,4 +12,5 @@ TARGET_LINK_LIBRARIES(kwallet-query
     Qt5::Widgets
 )
 
+ecm_mark_nongui_executable(kwallet-query)
 install( TARGETS kwallet-query DESTINATION ${KDE_INSTALL_TARGETS_DEFAULT_ARGS})
diff --git a/src/runtime/kwalletd/CMakeLists.txt b/src/runtime/kwalletd/CMakeLists.txt
index 3f2a1de..691f20e 100644
--- a/src/runtime/kwalletd/CMakeLists.txt
+++ b/src/runtime/kwalletd/CMakeLists.txt
@@ -115,6 +115,7 @@ if (Gpgmepp_FOUND)
     kde_target_enable_exceptions(kwalletd5 PRIVATE)
 endif(Gpgmepp_FOUND)
 
+ecm_mark_nongui_executable(kwalletd5)
 install(TARGETS kwalletd5  ${KF5_INSTALL_TARGETS_DEFAULT_ARGS})
 
 ########### install files ###############
