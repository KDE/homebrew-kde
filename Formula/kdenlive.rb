require_relative "../lib/cmake"

class Kdenlive < Formula
  desc "Video editor"
  homepage "https://www.kdenlive.org/"
  url "https://download.kde.org/stable/release-service/21.08.2/src/kdenlive-21.08.2.tar.xz"
  sha256 "f59c3749f1432cf04151a657a7e345ac45f76e75dbc7a3d411b31dd93430a183"
  head "https://invent.kde.org/multimedia/kdenlive.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build
  depends_on "shared-mime-info" => :build

  depends_on "cdrtools"
  depends_on "dvdauthor"
  depends_on "ffmpeg"
  depends_on "hicolor-icon-theme"
  depends_on "kde-mac/kde/kf5-breeze-icons"
  depends_on "kde-mac/kde/kf5-kdeclarative"
  depends_on "kde-mac/kde/kf5-kfilemetadata"
  depends_on "kde-mac/kde/kf5-knewstuff"
  depends_on "kde-mac/kde/kf5-knotifyconfig"
  depends_on "libdv"
  depends_on "mlt"

  depends_on "kde-mac/kde/qt-webkit" => :optional

  patch :DATA

  def install
    args = kde_cmake_args

    args << ("-DQt5WebKitWidgets_DIR=" + Formula["qt-webkit"].opt_prefix + "/lib/cmake/Qt5WebKitWidgets")
    args << "-DUPDATE_MIME_DATABASE_EXECUTABLE=OFF"

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
    # Extract Qt plugin path
    qtpp = `#{Formula["qt@5"].bin}/qtpaths --plugin-dir`.chomp
    system "/usr/libexec/PlistBuddy",
      "-c", "Add :LSEnvironment:QT_PLUGIN_PATH string \"#{qtpp}\:#{HOMEBREW_PREFIX}/lib/qt5/plugins\"",
      "#{bin}/kdenlive.app/Contents/Info.plist"

    # Rename the .so files
    mv "#{lib}/qt5/plugins/mltpreview.so", "#{lib}/qt5/plugins/mltpreview.dylib"
  end

  def post_install
    mkdir_p HOMEBREW_PREFIX/"share/kdenlive"
    ln_sf HOMEBREW_PREFIX/"share/icons/breeze/breeze-icons.rcc", HOMEBREW_PREFIX/"share/kdenlive/icontheme.rcc"
  end

  def caveats
    <<~EOS
      You need to take some manual steps in order to make this formula work:
        "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"

      OTHER NOTES
      -----------
      When starting the program it may be crash, solved it changing in ~/Library/Preferences/kdenliverc
      from true to false: Window-Maximized = false
      For ffmpeg, you could install --with-: chromaprint fdk-aac fontconfig freetype frei0r game-music-emu libass libbluray libbs2b libcaca libgsm libmodplug libsoxr libssh libvidstab libvorbis libvpx opencore-amr openh264 openjpeg openssl opus rtmpdump rubberband sdl2 snappy speex srt tesseract theora tools two-lame wavpack webp x265 xz zeromq zimg

      There seems to be a problem with librsvg
    EOS
  end

  test do
    assert_match "help", shell_output("#{bin}/kdenlive.app/Contents/MacOS/kdenlive --help")
  end
end

# Fix shared-mime-info for use with ECM instead of set as hard requeriment.

__END__
diff --git a/data/CMakeLists.txt b/data/CMakeLists.txt
index a69ba42..8bf8b1c 100644
--- a/data/CMakeLists.txt
+++ b/data/CMakeLists.txt
@@ -33,7 +33,13 @@ install(FILES profiles.xml DESTINATION ${DATA_INSTALL_DIR}/kdenlive/export)
 install(FILES org.kde.kdenlive.appdata.xml DESTINATION ${KDE_INSTALL_METAINFODIR})
 install(FILES org.kde.kdenlive.desktop DESTINATION ${XDG_APPS_INSTALL_DIR})

-find_package(SharedMimeInfo REQUIRED)
+find_package(SharedMimeInfo 0.70)
+set_package_properties(SharedMimeInfo PROPERTIES
+                       TYPE OPTIONAL
+                       PURPOSE "Allows KDE applications to determine file types"
+                       )
 install(FILES org.kde.kdenlive.xml westley.xml DESTINATION ${XDG_MIME_INSTALL_DIR})
-update_xdg_mimetypes(${XDG_MIME_INSTALL_DIR})
+if(SharedMimeInfo_FOUND)
+    update_xdg_mimetypes(${KDE_INSTALL_MIMEDIR})
+endif()

