require "formula"

class Okteta < Formula
  desc "KDE hex editor for viewing and editing the raw data of files"
  homepage "http://www.kde.org/"
  url "https://download.kde.org/stable/applications/17.08.2/src/okteta-17.08.2.tar.xz"
  sha256 "780101c477e5af799d59300a1b2d65635ad715a60e4a48468c8df5d0bcbf2fb8"

  head "git://anongit.kde.org/okteta.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build

  depends_on "qt"
  depends_on "qca"
  depends_on "KDE-mac/kde/kf5-kcmutils"
  depends_on "KDE-mac/kde/kf5-kparts"
  depends_on "KDE-mac/kde/kf5-knewstuff"

  patch :DATA

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"
    args << "-DCMAKE_INSTALL_BUNDLEDIR=#{prefix}/bin"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"

      system "/usr/libexec/PlistBuddy",
        "-c", "Add :LSEnvironment:QT_PLUGIN_PATH string \"#{HOMEBREW_PREFIX}/lib/qt5/plugins\"",
        "#{bin}/okteta.app/Contents/Info.plist"
    end
  end

  def post_install
    system HOMEBREW_PREFIX/"bin/update-mime-database", HOMEBREW_PREFIX/"share/mime"
    ln_sf HOMEBREW_PREFIX/"share/icons/breeze/breeze-icons.rcc", HOMEBREW_PREFIX/"share/okteta/icontheme.rcc"
  end

  def caveats; <<-EOS.undent
    You need to take some manual steps in order to make this formula work:
      ln -sf "$(brew --prefix)/share/okteta ~/Library/"Application Support"
      mkdir -p ~/Applications/KDE
      ln -sf "#{prefix}/bin/okteta.app" ~/Applications/KDE/
    EOS
  end
end

__END__
--- a/mimetypes/CMakeLists.txt	2017-10-29 06:06:00.746991760 +0100
+++ b/mimetypes/CMakeLists.txt	2017-10-29 06:06:13.473170586 +0100
@@ -3,4 +3,6 @@
 find_package( SharedMimeInfo REQUIRED )
 
 install( FILES okteta.xml  DESTINATION ${KDE_INSTALL_MIMEDIR} )
-update_xdg_mimetypes( ${KDE_INSTALL_MIMEDIR} )
+
+# Need generate out of brew by update-mime-database
+#update_xdg_mimetypes( ${KDE_INSTALL_MIMEDIR} )

