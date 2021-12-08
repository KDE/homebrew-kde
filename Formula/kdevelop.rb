require_relative "../lib/cmake"

class Kdevelop < Formula
  desc "Cross-platform IDE for C, C++, Python, QML/JavaScript and PHP"
  homepage "https://kdevelop.org"
  url "https://download.kde.org/stable/kdevelop/5.6.2/src/kdevelop-5.6.2.tar.xz"
  sha256 "0f86bc3fe53f761c1e3e3f7544577a0c41433be8bff310cf2e729f76f4363bf6"
  revision 1
  head "https://invent.kde.org/kdevelop/kdevelop.git", branch: "master"

  depends_on "boost" => :build
  depends_on "cvs" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "kde-mac/kde/kdevelop-pg-qt" => :build
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build
  depends_on "shared-mime-info" => :build

  depends_on "cmake"
  depends_on "cppcheck"
  depends_on "kde-mac/kde/grantlee"
  depends_on "kde-mac/kde/kf5-breeze-icons"
  depends_on "kde-mac/kde/kf5-kcmutils"
  depends_on "kde-mac/kde/kf5-kitemmodels"
  depends_on "kde-mac/kde/kf5-knewstuff"
  depends_on "kde-mac/kde/kf5-knotifyconfig"
  depends_on "kde-mac/kde/kf5-ktexteditor"
  depends_on "kde-mac/kde/kf5-plasma-framework"
  depends_on "kde-mac/kde/konsole"
  depends_on "kde-mac/kde/ksysguard"
  depends_on "kde-mac/kde/libkomparediff2"
  depends_on "llvm"
  depends_on "subversion"
  depends_on "threadweaver"

  # isn't packaged on ARM64 macOS
  depends_on "gdb" => :recommended if OS.mac? && Hardware::CPU.intel?

  conflicts_with "kde-mac/kde/kdevplatform", because: "now included in Kdevelop"

  patch :DATA

  def install
    args = kde_cmake_args
    args << "-DUPDATE_MIME_DATABASE_EXECUTABLE=OFF"

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
    qtpp = `#{Formula["qt@5"].bin}/qtpaths --plugin-dir`.chomp
    chmod "+w", "#{bin}/kdevelop.app/Contents/Info.plist"
    system "/usr/libexec/PlistBuddy",
    "-c", "Add :LSEnvironment:QT_PLUGIN_PATH string \"#{qtpp}\:#{HOMEBREW_PREFIX}/lib/qt5/plugins\"",
    "#{bin}/kdevelop.app/Contents/Info.plist"
    chmod "-w", "#{bin}/kdevelop.app/Contents/Info.plist"
  end

  def post_install
    system HOMEBREW_PREFIX/"bin/update-mime-database", HOMEBREW_PREFIX/"share/mime"
    mkdir_p HOMEBREW_PREFIX/"share/kdevelop"
    ln_sf HOMEBREW_PREFIX/"share/icons/breeze/breeze-icons.rcc", HOMEBREW_PREFIX/"share/kdevelop/icontheme.rcc"
  end

  def caveats
    <<~EOS
      You need to take some manual steps in order to make this formula work:
        "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
    EOS
  end

  test do
    assert_match "help", shell_output("#{bin}/kdevelop.app/Contents/MacOS/kdevelop --help")
  end
end

# Set shared-mime-info as optional.

__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 55dabcc..28a9f6e 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -81,7 +81,12 @@ set_package_properties(KDevelop-PG-Qt PROPERTIES
     TYPE RECOMMENDED
 )

-find_package(SharedMimeInfo REQUIRED)
+# shared-mime-info 0.70 is mandatory for generic-icon
+find_package(SharedMimeInfo 0.70)
+set_package_properties(SharedMimeInfo PROPERTIES
+                       TYPE OPTIONAL
+                       PURPOSE "Allows KDE applications to determine file types"
+                      )

 if(NOT CMAKE_VERSION VERSION_LESS "3.10.0" AND KF5_VERSION VERSION_LESS "5.42.0")
   # CMake 3.9+ warns about automoc on files without Q_OBJECT, and doesn't know about other macros.
diff --git a/plugins/git/CMakeLists.txt b/plugins/git/CMakeLists.txt
index 8c6c711..e6c3650 100644
--- a/plugins/git/CMakeLists.txt
+++ b/plugins/git/CMakeLists.txt
@@ -36,4 +36,7 @@ add_subdirectory(icons)
 install(PROGRAMS org.kde.kdevelop_git.desktop DESTINATION ${KDE_INSTALL_APPDIR})
 
 install(FILES kdevgit.xml DESTINATION ${KDE_INSTALL_MIMEDIR})
-update_xdg_mimetypes(${KDE_INSTALL_MIMEDIR})
+# update XDG mime-types if shared mime info is around
+if(SharedMimeInfo_FOUND)
+    update_xdg_mimetypes(${KDE_INSTALL_MIMEDIR})
+endif()
diff --git a/plugins/clang/CMakeLists.txt b/plugins/clang/CMakeLists.txt
index 0ed104f..f8067c5 100644
--- a/plugins/clang/CMakeLists.txt
+++ b/plugins/clang/CMakeLists.txt
@@ -130,4 +130,7 @@ target_link_libraries(kdevclangsupport
 )
 
 install(FILES kdevclang.xml DESTINATION ${KDE_INSTALL_MIMEDIR})
-update_xdg_mimetypes(${KDE_INSTALL_MIMEDIR})
+# update XDG mime-types if shared mime info is around
+if(SharedMimeInfo_FOUND)
+    update_xdg_mimetypes(${KDE_INSTALL_MIMEDIR})
+endif()

