class KioExtras < Formula
  desc "Additional components to increase the functionality of KIO"
  homepage "https://www.kde.org/applications/internet/"
  url "https://download.kde.org/stable/applications/18.08.1/src/kio-extras-18.08.1.tar.xz"
  sha256 "dc3f185908c05e02c555f36b7ef182e6a935b990e28d71f835c5e051d842060f"

  head "git://anongit.kde.org/kio-extras.git"

  depends_on "cmake" => :build
  depends_on "gperf" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build
  depends_on "exiv2"
  depends_on "KDE-mac/kde/kf5-kdnssd"
  depends_on "KDE-mac/kde/kf5-kio"
  depends_on "KDE-mac/kde/kf5-kpty"
  depends_on "libmtp"
  depends_on "openexr"
  depends_on "openslp"
  depends_on "KDE-mac/kde/kf5-khtml" => :optional
  depends_on "KDE-mac/kde/kf5-kimageformats" => :optional
  depends_on "taglib" => :optional

  patch :DATA

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end

  def post_install
    system HOMEBREW_PREFIX/"bin/update-mime-database", HOMEBREW_PREFIX/"share/mime"
  end

  def caveats; <<~EOS
    You need to take some manual steps in order to make this formula work:
      ln -sfv "$(brew --prefix)/share/config.kcfg" "$HOME/Library/Application Support"
      ln -sfv "$(brew --prefix)/share/kio_bookmarks" "$HOME/Library/Application Support"
      ln -sfv "$(brew --prefix)/share/kio_info" "$HOME/Library/Application Support"
      ln -sfv "$(brew --prefix)/share/konqsidebartng" "$HOME/Library/Application Support"
      ln -sfv "$(brew --prefix)/share/konqueror" "$HOME/Library/Application Support"
      ln -sfv "$(brew --prefix)/share/kservices5" "$HOME/Library/Application Support"
      ln -sfv "$(brew --prefix)/share/kservicetypes5" "$HOME/Library/Application Support"
      ln -sfv "$(brew --prefix)/share/remoteview" "$HOME/Library/Application Support"
      ln -sfv "$(brew --prefix)/share/solid" "$HOME/Library/Application Support"
  EOS
  end
end

__END__
diff --git a/network/mimetypes/CMakeLists.txt b/network/mimetypes/CMakeLists.txt
index c0272256..5d6712c1 100644
--- a/network/mimetypes/CMakeLists.txt
+++ b/network/mimetypes/CMakeLists.txt
@@ -3,4 +3,5 @@ set( SHARED_MIME_INFO_MINIMUM_VERSION "0.40" )
 find_package( SharedMimeInfo REQUIRED )
 
 install( FILES network.xml  DESTINATION ${XDG_MIME_INSTALL_DIR} RENAME kf5_network.xml )
-update_xdg_mimetypes( ${XDG_MIME_INSTALL_DIR} )
+# Need generate out of brew by update-mime-database
+#update_xdg_mimetypes( ${XDG_MIME_INSTALL_DIR} )
