class Poxml < Formula
  desc "Translates DocBook XML files using gettext po files"
  homepage "https://www.kde.org/applications/development/"
  url "https://download.kde.org/stable/applications/19.04.0/src/poxml-19.04.0.tar.xz"
  sha256 "c0a24557cc7e243790c5273fb2a4ff585a3e89cc994772a52979015d2e57a985"
  revision 1
  head "git://anongit.kde.org/poxml.git"

  depends_on "cmake" => :build
  depends_on "ninja" => :build

  depends_on "gettext"
  depends_on "KDE-mac/kde/kf5-kdoctools"
  depends_on "qt"

  patch :DATA

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end

  test do
    assert_includes "english-XML", `$(brew --prefix)/opt/poxml/bin/po2xml.app/Contents/MacOS/po2xml`
  end
end

# Mark executables as nongui type

__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 9d6ea4e..c7a87fe 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -8,6 +8,7 @@ set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${ECM_MODULE_PATH} ${ECM_KDE_MODULE_D
 include(FeatureSummary)
 include(ECMAddAppIcon)
 include(ECMInstallIcons)
+include(ECMMarkNonGuiExecutable)
 include(KDEInstallDirs)
 include(KDECompilerSettings NO_POLICY_SCOPE)
 include(KDECMakeSettings)
@@ -37,6 +38,8 @@ add_executable(split2po ${split2po_SRCS})
 
 target_link_libraries(split2po ${GETTEXTPO_LIBRARY} Qt5::Xml Qt5::Core)
 
+ecm_mark_nongui_executable(split2po)
+
 install(TARGETS split2po  ${KDE_INSTALL_TARGETS_DEFAULT_ARGS})
 
 
@@ -49,6 +52,8 @@ add_executable(xml2pot ${xml2pot_SRCS})
 
 target_link_libraries(xml2pot ${GETTEXTPO_LIBRARY} Qt5::Xml Qt5::Core)
 
+ecm_mark_nongui_executable(xml2pot)
+
 install(TARGETS xml2pot  ${KDE_INSTALL_TARGETS_DEFAULT_ARGS})
 
 
@@ -64,6 +69,8 @@ add_executable(po2xml ${po2xml_SRCS})
 
 target_link_libraries(po2xml ${GETTEXTPO_LIBRARY} Qt5::Xml Qt5::Core)
 
+ecm_mark_nongui_executable(po2xml)
+
 install(TARGETS po2xml  ${KDE_INSTALL_TARGETS_DEFAULT_ARGS})
 
 
@@ -78,6 +85,8 @@ add_executable(swappo ${swappo_SRCS})
 
 target_link_libraries(swappo ${GETTEXTPO_LIBRARY})
 
+ecm_mark_nongui_executable(swappo)
+
 install(TARGETS swappo  ${KDE_INSTALL_TARGETS_DEFAULT_ARGS})
 
