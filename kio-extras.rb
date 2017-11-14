class KioExtras < Formula
  desc "Additional components to increase the functionality of KIO"
  homepage "https://www.kde.org/applications/internet/"
  url "https://download.kde.org/stable/applications/17.08.3/src/kio-extras-17.08.3.tar.xz"
  sha256 "4c268b22a50d7ed08dbb7211a34e562aa10c2cbb2c62fb4311a0f932c841013f"

  head "git://anongit.kde.org/kio-extras.git"

  depends_on "cmake" => :build
  depends_on "gperf" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build

  depends_on "taglib" => [:build, :optional]
  depends_on "KDE-mac/kde/khtml" => [:build, :optional]
  depends_on "KDE-mac/kde/kimageformats" => :optional

  depends_on "qt"
  depends_on "exiv2"
  depends_on "libssh"
  depends_on "openexr"
  depends_on "openslp"
  depends_on "libmtp"
  depends_on "KDE-mac/kde/kf5-kactivities"
  depends_on "KDE-mac/kde/kf5-kdnssd"
  depends_on "KDE-mac/kde/kf5-kio"
  depends_on "KDE-mac/kde/kf5-kpty"

  patch :DATA

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"
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
