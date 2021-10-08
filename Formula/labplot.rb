require_relative "../lib/cmake"

class Labplot < Formula
  desc "Application for interactive graphing and analysis of scientific data"
  homepage "https://labplot.kde.org/"
  url "https://download.kde.org/stable/labplot/2.8.1/labplot-2.8.1.tar.xz"
  sha256 "726909a8335921c742c4d92f66663ecdb447ddee0d74568c50a22330c79e079a"
  revision 1
  head "https://invent.kde.org/education/labplot.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "kdoctools" => :build
  depends_on "kf5-kdelibs4support" => :build
  depends_on "kf5-kdesignerplugin" => :build
  depends_on "ninja" => :build
  depends_on "shared-mime-info" => :build

  depends_on "cfitsio"
  depends_on "fftw"
  depends_on "gettext"
  depends_on "gsl"
  depends_on "libcerf"
  depends_on "netcdf"
  depends_on "qt@5"

  patch :DATA

  def install
    args = kde_cmake_arg
    sargs << "-DUPDATE_MIME_DATABASE_EXECUTABLE=OFF"

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
    # see https://github.com/KDE-mac/homebrew-kde/pull/242
    ln_sf "#{share}/kxmlgui5/labplot2/labplot2ui.rc", "#{bin}/labplot2.app/Contents/Resources/labplot2ui.rc"
  end

  def post_install
    system HOMEBREW_PREFIX/"bin/update-mime-database", HOMEBREW_PREFIX/"share/mime"
    mkdir_p HOMEBREW_PREFIX/"share/labplot2"
    ln_sf HOMEBREW_PREFIX/"share/icons/breeze/breeze-icons.rcc", HOMEBREW_PREFIX/"share/labplot2/icontheme.rcc"
  end

  def caveats
    <<~EOS
      You need to take some manual steps in order to make this formula work:
         "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
    EOS
  end

  test do
    assert_match "help", shell_output("#{bin}/labplot.app/Contents/MacOS/labplot --help")
  end
end

# Fix shared-mime-info for use with ECM instead of set as hard requeriment.

__END__
diff --git a/src/CMakeLists.txt b/src/CMakeLists.txt
index 042b5a1..e4bd13e 100644
--- a/src/CMakeLists.txt
+++ b/src/CMakeLists.txt
@@ -1,4 +1,8 @@
-find_package(SharedMimeInfo REQUIRED)
+find_package(SharedMimeInfo 0.70)
+set_package_properties(SharedMimeInfo PROPERTIES
+                       TYPE OPTIONAL
+                       PURPOSE "Allows KDE applications to determine file types"
+                       )
 set(KDE_FRONTEND true)
 set(KDEFRONTEND_DIR kdefrontend)
 set(BACKEND_DIR backend)
@@ -471,4 +474,7 @@ install( PROGRAMS org.kde.labplot2.desktop DESTINATION ${XDG_APPS_INSTALL_DIR} )
 install( FILES labplot2.xml DESTINATION ${XDG_MIME_INSTALL_DIR} )
 install( FILES labplot2_themes.knsrc DESTINATION ${CONFIG_INSTALL_DIR} )
-update_xdg_mimetypes( ${XDG_MIME_INSTALL_DIR} )
+# update XDG mime-types if shared mime info is around
+if(SharedMimeInfo_FOUND)
+    update_xdg_mimetypes(${KDE_INSTALL_MIMEDIR})
+endif()
