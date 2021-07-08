require_relative "../lib/cmake"

class Okular < Formula
  desc "Document Viewer"
  homepage "https://okular.kde.org"
  url "https://download.kde.org/stable/release-service/21.04.3/src/okular-21.04.3.tar.xz"
  sha256 "fa1fc1a4a4d84c1e568665d4c05cd00f71c5ba481dad7b6b8d83597a428b5056"
  head "https://invent.kde.org/graphics/okular.git"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "chmlib"
  depends_on "djvulibre"
  depends_on "ebook-tools"
  depends_on "freetype"
  depends_on "kde-mac/kde/kf5-breeze-icons"
  depends_on "kde-mac/kde/kf5-kactivities"
  depends_on "kde-mac/kde/kf5-khtml"
  depends_on "kde-mac/kde/kf5-kirigami2"
  depends_on "kde-mac/kde/kf5-kjs"
  depends_on "kde-mac/kde/kf5-kparts"
  depends_on "kde-mac/kde/kf5-kpty"
  depends_on "kde-mac/kde/libkexiv2"
  depends_on "kde-mac/kde/phonon"
  depends_on "libspectre"
  depends_on "poppler"
  depends_on "qca"
  depends_on "threadweaver"
  depends_on "zlib"

  patch :DATA

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
    # Extract Qt plugin and QML2 path
    mkdir "getqmlpath" do
      (Pathname.pwd/"main.cpp").write <<~EOS
        #include <QTextStream>
        #include <QLibraryInfo>
        int main() {
          QTextStream out(stdout);
          out << QLibraryInfo::location(QLibraryInfo::Qml2ImportsPath) << endl;
        }
      EOS

      (Pathname.pwd/"qmlpath.pro").write <<~EOS
        QT += core
        TEMPLATE = app
        TARGET = qmlpath
        CONFIG += cmdline
        CONFIG += silent
        SOURCES += main.cpp
      EOS

      system "#{Formula["qt@5"].bin}/qmake"
      system "make"
    end
    qtpp = Utils.safe_popen_read("#{Formula[qt].bin}/qtpaths", "--plugin-dir").chomp
    qml2pp = Utils.safe_popen_read("./getqmlpath/qmlpath").chomp
    system "/usr/libexec/PlistBuddy",
      "-c", "Add :LSEnvironment:QT_PLUGIN_PATH string \"#{qtpp}\:#{HOMEBREW_PREFIX}/lib/qt5/plugins\"",
      "#{bin}/okular.app/Contents/Info.plist"
    system "/usr/libexec/PlistBuddy",
      "-c", "Add :LSEnvironment:QT_PLUGIN_PATH string \"#{qtpp}\:#{HOMEBREW_PREFIX}/lib/qt5/plugins\"",
      "-c", "Add :LSEnvironment:QML2_IMPORT_PATH string \"#{qml2pp}\:#{HOMEBREW_PREFIX}/lib/qt5/qml\"",
      "#{bin}/okularkirigami.app/Contents/Info.plist"
  end

  def post_install
    mkdir_p HOMEBREW_PREFIX/"share/okular"
    ln_sf HOMEBREW_PREFIX/"share/icons/breeze/breeze-icons.rcc", HOMEBREW_PREFIX/"share/okular/icontheme.rcc"
  end

  def caveats
    <<~EOS
      You need to take some manual steps in order to make this formula work:
        "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
    EOS
  end

  test do
    assert_match "help", shell_output("#{bin}/okular.app/Contents/MacOS/okular --help")
    assert_match "help", shell_output("#{bin}/okularkirigami.app/Contents/MacOS/okularkirigami --help")
  end
end

# Fix build
# Fix Retina display

__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 579379dc8..cd59e37f3 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -261,7 +261,7 @@ endif()

 # Special handling for linking okularcore on OSX/Apple
 IF(APPLE)
-    SET(OKULAR_IOKIT "-framework IOKit" CACHE STRING "Apple IOKit framework")
+    SET(OKULAR_IOKIT "-framework CoreFoundation -framework CoreGraphics -framework IOKit" CACHE STRING "Apple IOKit framework")
 ENDIF(APPLE)

 # Extra library needed by imported synctex code on Windows
diff --git a/shell/CMakeLists.txt b/shell/CMakeLists.txt
index 628f74be1..f4e807dc5 100644
--- a/shell/CMakeLists.txt
+++ b/shell/CMakeLists.txt
@@ -25,6 +25,7 @@ if(TARGET KF5::Activities)
 	target_link_libraries(okular KF5::Activities)
 endif()

+set_target_properties(okular PROPERTIES MACOSX_BUNDLE_INFO_PLIST ${CMAKE_CURRENT_SOURCE_DIR}/MacOSXBundleInfo.plist.in)
 install(TARGETS okular ${KDE_INSTALL_TARGETS_DEFAULT_ARGS})


diff --git a/shell/MacOSXBundleInfo.plist.in b/shell/MacOSXBundleInfo.plist.in
new file mode 100644
index 000000000..ab421eaf8
--- /dev/null
+++ b/shell/MacOSXBundleInfo.plist.in
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
