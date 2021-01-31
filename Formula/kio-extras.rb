require_relative "../lib/cmake"

class KioExtras < Formula
  desc "Additional components to increase the functionality of KIO"
  homepage "https://www.kde.org/applications/internet/"
  url "https://download.kde.org/stable/release-service/20.12.2/src/kio-extras-20.12.2.tar.xz"
  sha256 "237df668c8bdeac4a362659c00b64c6e89d8b60080fcbdcaf21f387a22e25ae4"
  head "https://invent.kde.org/network/kio-extras.git"

  depends_on "cmake" => [:build, :test]
  depends_on "gperf" => :build
  depends_on "kde-extra-cmake-modules" => [:build, :test]
  depends_on "kde-kdoctools" => :build
  depends_on "ninja" => :build
  depends_on "shared-mime-info" => :build

  depends_on "exiv2"
  depends_on "kde-mac/kde/kf5-kdnssd"
  depends_on "kde-mac/kde/kf5-khtml"
  depends_on "kde-mac/kde/kf5-kimageformats"
  depends_on "kde-mac/kde/kf5-kio"
  depends_on "kde-mac/kde/kf5-kpty"
  depends_on "kde-mac/kde/kf5-syntax-highlighting"
  depends_on "libmtp"
  depends_on "openexr"
  depends_on "openslp"

  conflicts_with "taglib", because: "linking errors"

  patch do
    # Fix https://bugs.kde.org/show_bug.cgi?id=402335 (#274)
    url "https://bugsfiles.kde.org/attachment.cgi?id=117165"
    sha256 "bce9033737ef90b038fa5521f0b9b5e192b8ae27a4fedc96eda76ac8f7943315"
  end

  patch :DATA

  def install
    args = kde_cmake_argsargs << "-DUPDATE_MIME_DATABASE_EXECUTABLE=OFF"

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  def post_install
    system HOMEBREW_PREFIX/"bin/update-mime-database", HOMEBREW_PREFIX/"share/mime"
  end

  def caveats
    <<~EOS
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
