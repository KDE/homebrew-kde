class Kf5Kdesignerplugin < Formula
  desc "Integration of Frameworks widgets in Qt Designer/Creator"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.57/kdesignerplugin-5.57.0.tar.xz"
  sha256 "9e85a4ac798122b459722773a6e81f639be6dfe9c9714a16704f555c88334393"

  head "git://anongit.kde.org/kdesignerplugin.git"
  depends_on "cmake" => :build
  depends_on "gettext" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "KDE-mac/kde/kf5-kio"
  depends_on "KDE-mac/kde/kf5-kplotting"
  depends_on "KDE-mac/kde/kf5-kdewebkit" => :optional

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

  def caveats; <<~EOS
    You need to take some manual steps in order to make this formula work:
      ln -sfv "$(brew --prefix)/share/kf5" "$HOME/Library/Application Support"
  EOS
  end
end

# Fix typo(?)
__END__
diff --git a/src/CMakeLists.txt b/src/CMakeLists.txt
index fac92fd..3f86d7b 100644
--- a/src/CMakeLists.txt
+++ b/src/CMakeLists.txt
@@ -55,7 +55,7 @@ if(BUILD_KF5_DESIGNER_PLUGIN)
         )
     endif()
 
-    install(TARGETS kf5widgets DESTINATION ${KDE_INSTALL_QTPLUGINDIR}/designer)
+    install(TARGETS kf5widgets DESTINATION ${KDE_INSTALL_PLUGINDIR}/designer)
 endif()
 
 
@@ -79,5 +79,5 @@ if(BUILD_KDEWEBKIT_DESIGNER_PLUGIN)
         )
     endif()
 
-    install(TARGETS kdewebkitwidgets DESTINATION ${KDE_INSTALL_QTPLUGINDIR}/designer)
+    install(TARGETS kdewebkitwidgets DESTINATION ${KDE_INSTALL_PLUGINDIR}/designer)
 endif()
