class Kcalc < Formula
  desc "KCalc"
  homepage "https://utils.kde.org/projects/kcalc/"
  url "https://download.kde.org/stable/applications/18.12.0/src/kcalc-18.12.0.tar.xz"
  sha256 "e078a0eb4becd00fef3b7c02b55468e4a2ef5f256106925555a9d9a7cbf68d97"

  head "git://anongit.kde.org/kcalc.git"

  depends_on "cmake" => :build
  depends_on "gettext" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build

  depends_on "KDE-mac/kde/kf5-breeze-icons"

  patch :DATA

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"
    args << "-DCMAKE_INSTALL_BUNDLEDIR=#{bin}"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end

  test do
    assert `"#{bin}"/kcalc.app/Contents/MacOS/kcalc --help | grep -- --help` =~ /--help/
  end
end

__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 4d42e2e..b7fac59 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -123,6 +123,7 @@ target_link_libraries(kdeinit_kcalc
 install(TARGETS kdeinit_kcalc ${KDE_INSTALL_TARGETS_DEFAULT_ARGS})

 target_link_libraries( kcalc kdeinit_kcalc )
+set_target_properties( kcalc PROPERTIES MACOSX_BUNDLE_INFO_PLIST ${CMAKE_CURRENT_SOURCE_DIR}/MacOSXBundleInfo.plist.in )
 install(TARGETS kcalc  ${KDE_INSTALL_TARGETS_DEFAULT_ARGS} )

 ########### install files ###############
diff --git a/MacOSXBundleInfo.plist.in b/MacOSXBundleInfo.plist.in
new file mode 100644
index 0000000..ab421ea
--- /dev/null
+++ b/MacOSXBundleInfo.plist.in
@@ -0,0 +1,55 @@
+<?xml version="1.0" encoding="UTF-8"?>
+<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
+<plist version="1.0">
+<dict>
+        <key>NSPrincipalClass</key>
+        <string>NSApplication</string>
+        <key>NSHighResolutionCapable</key>
+        <string>True</string>
+        <key>CFBundleDevelopmentRegion</key>
+        <string>English</string>
+        <key>CFBundleExecutable</key>
+        <string>${MACOSX_BUNDLE_EXECUTABLE_NAME}</string>
+        <key>CFBundleGetInfoString</key>
+        <string>${MACOSX_BUNDLE_INFO_STRING}</string>
+        <key>CFBundleIconFile</key>
+        <string>${MACOSX_BUNDLE_ICON_FILE}</string>
+        <key>CFBundleIdentifier</key>
+        <string>${MACOSX_BUNDLE_GUI_IDENTIFIER}</string>
+        <key>CFBundleInfoDictionaryVersion</key>
+        <string>6.0</string>
+        <key>CFBundleLongVersionString</key>
+        <string>${MACOSX_BUNDLE_LONG_VERSION_STRING}</string>
+        <key>CFBundleName</key>
+        <string>${MACOSX_BUNDLE_BUNDLE_NAME}</string>
+        <key>CFBundlePackageType</key>
+        <string>APPL</string>
+        <key>CFBundleShortVersionString</key>
+        <string>${MACOSX_BUNDLE_SHORT_VERSION_STRING}</string>
+        <key>CFBundleSignature</key>
+        <string>????</string>
+        <key>CFBundleVersion</key>
+        <string>${MACOSX_BUNDLE_BUNDLE_VERSION}</string>
+        <key>CSResourcesFileMapped</key>
+        <true/>
+        <key>LSRequiresCarbon</key>
+        <true/>
+        <key>NSHumanReadableCopyright</key>
+        <string>${MACOSX_BUNDLE_COPYRIGHT}</string>
+        <key>LSMultipleInstancesProhibited</key>
+        <true/>
+        <key>CFBundleDocumentTypes</key>
+        <array>
+            <dict>
+                <key>CFBundleTypeExtensions</key>
+                <array>
+                        <string>*</string>
+                </array>
+                <key>CFBundleTypeName</key>
+                <string>NSStringPboardType</string>
+                <key>CFBundleTypeRole</key>
+                <string>Editor</string>
+            </dict>
+        </array>
+</dict>
+</plist>
