class Labplot < Formula
  desc "Application for interactive graphing and analysis of scientific data"
  homepage "https://labplot.kde.org/"
  url "https://download.kde.org/stable/labplot/2.7.0/labplot-2.7.0.tar.xz"
  sha256 "5c4d6ed7df6e98557a6b78f018933c92654b7e50e7f051ad89ec4755e0f4e935"
  head "https://invent.kde.org/education/labplot.git"

  depends_on "cmake" => [:build, :test]
  depends_on "kde-extra-cmake-modules" => [:build, :test]
  depends_on "kf5-kdelibs4support" => :build
  depends_on "kf5-kdesignerplugin" => :build
  depends_on "kf5-kdoctools" => :build
  depends_on "ninja" => :build
  depends_on "shared-mime-info" => :build

  depends_on "cfitsio"
  depends_on "fftw"
  depends_on "gettext"
  depends_on "gsl"
  depends_on "libcerf"
  depends_on "netcdf"
  depends_on "qt"

  patch :DATA

  def install
    args = std_cmake_args
    args << "-DCMAKE_INSTALL_BUNDLEDIR=#{bin}"
    args << "-DUPDATE_MIME_DATABASE_EXECUTABLE=OFF"

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
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
    assert `"#{bin}/labplot.app/Contents/MacOS/labplot" --help | grep -- --help`.include?("--help")
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
