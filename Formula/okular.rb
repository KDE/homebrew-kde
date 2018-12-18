class Okular < Formula
  desc "Document Viewer"
  homepage "https://okular.kde.org"
  url "https://download.kde.org/stable/applications/18.12.0/src/okular-18.12.0.tar.xz"
  sha256 "915643d16b26c352cfa8461647a08701b50b7802c7e628ff303d74af313599a0"

  head "git://anongit.kde.org/okular.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build

  depends_on "djvulibre"
  depends_on "freetype"
  depends_on "KDE-mac/kde/kf5-breeze-icons"
  depends_on "KDE-mac/kde/kf5-kactivities"
  depends_on "KDE-mac/kde/kf5-kjs"
  depends_on "KDE-mac/kde/kf5-kparts"
  depends_on "KDE-mac/kde/kf5-kpty"
  depends_on "KDE-mac/kde/kf5-threadweaver"
  depends_on "KDE-mac/kde/libkexiv2"
  depends_on "libspectre"
  depends_on "poppler" => "--with-qt"
  depends_on "qca"
  depends_on "zlib"
  depends_on "chmlib" => :optional
  depends_on "ebook-tools" => :optional
  depends_on "KDE-mac/kde/kf5-khtml" => :optional
  depends_on "KDE-mac/kde/kf5-kirigami2" => :optional

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
    # Extract Qt plugin path
    qtpp = `#{Formula["qt"].bin}/qtpaths --plugin-dir`.chomp
    system "/usr/libexec/PlistBuddy",
      "-c", "Add :LSEnvironment:QT_PLUGIN_PATH string \"#{qtpp}\:#{HOMEBREW_PREFIX}/lib/qt5/plugins\"",
      "#{bin}/okular.app/Contents/Info.plist"
  end

  def post_install
    mkdir_p HOMEBREW_PREFIX/"share/okular"
    ln_sf HOMEBREW_PREFIX/"share/icons/breeze/breeze-icons.rcc", HOMEBREW_PREFIX/"share/okular/icontheme.rcc"
  end

  def caveats; <<~EOS
    You need to take some manual steps in order to make this formula work:
      ln -sfv "$(brew --prefix)/share/okular" "$HOME/Library/Application Support"
      ln -sfv "$(brew --prefix)/share/kconf_update" "$HOME/Library/Application Support"
      ln -sfv "$(brew --prefix)/share/config.kcfg" "$HOME/Library/Application Support"
      ln -sfv "$(brew --prefix)/share/kservices5" "$HOME/Library/Application Support"
      ln -sfv "$(brew --prefix)/share/kservicetypes5" "$HOME/Library/Application Support"
      ln -sfv "$(brew --prefix)/share/kxmlgui5" "$HOME/Library/Application Support"
      ln -sfv "$(brew --prefix)/share/metainfo" "$HOME/Library/Application Support"
      mkdir -pv "$HOME/Applications/KDE"
      ln -sfv "$(brew --prefix)/opt/okular/bin/okular.app" "$HOME/Applications/KDE/"
  EOS
  end
end

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
