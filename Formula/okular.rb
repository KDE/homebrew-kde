class Okular < Formula
  desc "Document Viewer"
  homepage "https://okular.kde.org"
  url "https://download.kde.org/stable/applications/18.04.2/src/okular-18.04.2.tar.xz"
  sha256 "bf9e4e9ce6cc6f7fae3dfe021ea7954403c7bab77a33434974eb3efe999999c9"

  head "git://anongit.kde.org/okular.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build

  depends_on "chmlib" => :optional
  depends_on "ebook-tools" => :optional
  depends_on "KDE-mac/kde/kf5-khtml" => :optional
  depends_on "KDE-mac/kde/kf5-kirigami2" => :optional

  depends_on "qca"
  depends_on "zlib"
  depends_on "freetype"
  depends_on "libspectre"
  depends_on "djvulibre"
  depends_on "poppler"
  depends_on "KDE-mac/kde/kf5-breeze-icons"
  depends_on "KDE-mac/kde/kf5-kactivities"
  depends_on "KDE-mac/kde/kf5-kjs"
  depends_on "KDE-mac/kde/kf5-kparts"
  depends_on "KDE-mac/kde/kf5-kpty"
  depends_on "KDE-mac/kde/kf5-threadweaver"
  depends_on "KDE-mac/kde/libkexiv2"

  patch do
    url "https://raw.githubusercontent.com/RJVB/macstrop/master/kf5/kf5-okular/files/patch-plugin-depends.diff"
    sha256 "33e5e0fa2a10fea2f11a1b975bfee3d87d80215aedb8013ea2d318818a250a46"
  end
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
    ln_sf HOMEBREW_PREFIX/"share/icons/breeze/breeze-icons.rcc", HOMEBREW_PREFIX/"share/okular/icontheme.rcc"
  end

  def caveats; <<~EOS
    You need to take some manual steps in order to make this formula work:
      ln -sf "$(brew --prefix)/share/okular" "$HOME/Library/Application Support"
      ln -sf "$(brew --prefix)/share/kconf_update" "$HOME/Library/Application Support"
      ln -sf "$(brew --prefix)/share/config.kcfg" "$HOME/Library/Application Support"
      ln -sf "$(brew --prefix)/share/kservices5" "$HOME/Library/Application Support"
      ln -sf "$(brew --prefix)/share/kservicetypes5" "$HOME/Library/Application Support"
      ln -sf "$(brew --prefix)/share/kxmlgui5" "$HOME/Library/Application Support"
      ln -sf "$(brew --prefix)/share/metainfo" "$HOME/Library/Application Support"
      mkdir -p $HOME/Applications/KDE
      ln -sf "#{prefix}/bin/okular.app" $HOME/Applications/KDE/
    EOS
  end
end

__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 7537220..5fef3d7 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -190,7 +190,7 @@ generate_export_header(okularcore BASE_NAME okularcore EXPORT_FILE_NAME "${CMAKE

 # Special handling for linking okularcore on OSX/Apple
 IF(APPLE)
-    SET(OKULAR_IOKIT "-framework IOKit" CACHE STRING "Apple IOKit framework")
+    SET(OKULAR_IOKIT "-framework CoreFoundation -framework CoreGraphics -framework IOKit" CACHE STRING "Apple IOKit framework")
 ENDIF(APPLE)

 target_link_libraries(okularcore
