require_relative "../lib/cmake"

class Kcalc < Formula
  desc "Calculator offering everything a scientific calculator does, and more"
  homepage "https://utils.kde.org/projects/kcalc/"
  url "https://download.kde.org/stable/release-service/21.04.3/src/kcalc-21.04.3.tar.xz"
  sha256 "cf389a1c4db1c7da8b5b7ecec030e9c68df5d950c581d91f3931b7f6d2a7cacf"
  head "https://invent.kde.org/utilities/kcalc.git"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "cmake" => [:build, :test]
  depends_on "gettext" => :build
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-breeze-icons"
  depends_on "kde-mac/kde/kf5-kinit"
  depends_on "mpfr"

  patch :DATA

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
    # Extract Qt plugin path
    qtpp = `#{Formula["qt@5"].bin}/qtpaths --plugin-dir`.chomp
    system "/usr/libexec/PlistBuddy",
      "-c", "Add :LSEnvironment:QT_PLUGIN_PATH string \"#{qtpp}\:#{HOMEBREW_PREFIX}/lib/qt5/plugins\"",
      "#{bin}/kcalc.app/Contents/Info.plist"
  end

  def post_install
    mkdir_p HOMEBREW_PREFIX/"share/kcalc"
    ln_sf HOMEBREW_PREFIX/"share/icons/breeze/breeze-icons.rcc", HOMEBREW_PREFIX/"share/kcalc/icontheme.rcc"
  end

  def caveats
    <<~EOS
      You need to take some manual steps in order to make this formula work:
        "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
    EOS
  end

  test do
    assert_match "help", shell_output("#{bin}/kcalc.app/Contents/MacOS/kcalc --help")
  end
end

# Fix retina display

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
