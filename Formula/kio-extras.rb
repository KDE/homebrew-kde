class KioExtras < Formula
  desc "Additional components to increase the functionality of KIO"
  homepage "https://www.kde.org/applications/internet/"
  url "https://download.kde.org/stable/release-service/20.04.0/src/kio-extras-20.04.0.tar.xz"
  sha256 "a70f6079a8d2acb8c64bf0d08f7f7e5685f2e9c4e49548c138609437fdc6cd4d"
  head "git://anongit.kde.org/kio-extras.git"

  depends_on "cmake" => :build
  depends_on "gperf" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build
  depends_on "ninja" => :build
  depends_on "shared-mime-info" => :build

  depends_on "exiv2"
  depends_on "KDE-mac/kde/kf5-kdnssd"
  depends_on "KDE-mac/kde/kf5-kio"
  depends_on "KDE-mac/kde/kf5-kpty"
  depends_on "KDE-mac/kde/kf5-syntax-highlighting"
  depends_on "libmtp"
  depends_on "openexr"
  depends_on "openslp"

  depends_on "KDE-mac/kde/kf5-khtml" => :optional
  depends_on "KDE-mac/kde/kf5-kimageformats" => :optional
  depends_on "taglib" => :optional

  patch do
    # Fix https://bugs.kde.org/show_bug.cgi?id=402335 (#274)
    url "https://bugsfiles.kde.org/attachment.cgi?id=117165"
    sha256 "bce9033737ef90b038fa5521f0b9b5e192b8ae27a4fedc96eda76ac8f7943315"
  end

  patch :DATA

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"
    args << "-DUPDATE_MIME_DATABASE_EXECUTABLE=OFF"

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end

  def post_install
    system HOMEBREW_PREFIX/"bin/update-mime-database", HOMEBREW_PREFIX/"share/mime"
  end

  def caveats; <<~EOS
    You need to take some manual steps in order to make this formula work:
      "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
  EOS
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5KioArchive REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end

# Set shared-mime-info as optional.

__END__
diff --git a/network/mimetypes/CMakeLists.txt b/network/mimetypes/CMakeLists.txt
index 4d7368b..3c5151f 100644
--- a/network/mimetypes/CMakeLists.txt
+++ b/network/mimetypes/CMakeLists.txt
@@ -1,6 +1,12 @@
-# shared-mime-info 0.40 is mandatory for generic-icon
-set( SHARED_MIME_INFO_MINIMUM_VERSION "0.40" )
-find_package( SharedMimeInfo REQUIRED )
+# shared-mime-info 0.70 is mandatory for generic-icon
+find_package(SharedMimeInfo 0.70)
+set_package_properties(SharedMimeInfo PROPERTIES
+                       TYPE OPTIONAL
+                       PURPOSE "Allows KDE applications to determine file types"
+                       )

 install( FILES network.xml  DESTINATION ${KDE_INSTALL_MIMEDIR} RENAME kf5_network.xml )
-update_xdg_mimetypes( ${KDE_INSTALL_MIMEDIR} )
+# update XDG mime-types if shared mime info is around
+if(SharedMimeInfo_FOUND)
+    update_xdg_mimetypes(${KDE_INSTALL_MIMEDIR})
+endif()
