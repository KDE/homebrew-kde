class Kf5Kio < Formula
  desc "Resource and network access abstraction"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.45/kio-5.45.0.tar.xz"
  sha256 "3e7512e819fe1831b15981641dba26a7dcbbdbccd79cbf076ceedae8e4116b15"

  head "git://anongit.kde.org/kio.git"

  # Fix getxattr which takes six inputs in macOS
  patch :DATA

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build

  depends_on "KDE-mac/kde/kio-extras" => :optional

  depends_on "desktop-file-utils"
  depends_on "libxslt"
  depends_on "KDE-mac/kde/kf5-kbookmarks"
  depends_on "KDE-mac/kde/kf5-kjobwidgets"
  depends_on "KDE-mac/kde/kf5-kwallet"
  depends_on "KDE-mac/kde/kf5-solid"

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

  def caveats; <<~EOS
    You need to take some manual steps in order to make this formula work:
      ln -sf "$(brew --prefix)/share/kf5" "$HOME/Library/Application Support"
      ln -sf "$(brew --prefix)/share/knotifications5" "$HOME/Library/Application Support"
      ln -sf "$(brew --prefix)/share/kservices5" "$HOME/Library/Application Support"
      ln -sf "$(brew --prefix)/share/kservicetypes5" "$HOME/Library/Application Support"
    EOS
  end
end

__END__
diff --git a/src/ioslaves/file/file_unix.cpp b/src/ioslaves/file/file_unix.cpp
index 9c9a83b..4eafbc8 100644
--- a/src/ioslaves/file/file_unix.cpp
+++ b/src/ioslaves/file/file_unix.cpp
@@ -418,13 +418,13 @@ static bool isNtfsHidden(const QString &filename)
 {
     constexpr auto attrName = "system.ntfs_attrib_be";
     const auto filenameEncoded = QFile::encodeName(filename);
-    auto length = getxattr(filenameEncoded.data(), attrName, nullptr, 0);
+    auto length = getxattr(filenameEncoded.data(), attrName, nullptr, 0, 0, XATTR_NOFOLLOW);
     if (length <= 0) {
         return false;
     }
     constexpr size_t xattr_size = 1024;
     char strAttr[xattr_size];
-    length = getxattr(filenameEncoded.data(), attrName, strAttr, xattr_size);
+    length = getxattr(filenameEncoded.data(), attrName, strAttr, xattr_size, 0, XATTR_NOFOLLOW);
     if (length <= 0) {
         return false;
     }
diff --git a/src/widgets/kpropertiesdialog.cpp b/src/widgets/kpropertiesdialog.cpp
index 17e1688..f2b8a37 100644
--- a/src/widgets/kpropertiesdialog.cpp
+++ b/src/widgets/kpropertiesdialog.cpp
@@ -1943,7 +1943,7 @@ static bool fileSystemSupportsACL(const QByteArray &path)
     fileSystemSupportsACLs = (statfs(path.data(), &buf) == 0) && (buf.f_flags & MNT_ACLS);
 #else
     fileSystemSupportsACLs =
-        getxattr(path.data(), "system.posix_acl_access", nullptr, 0) >= 0 || errno == ENODATA;
+        getxattr(path.data(), "system.posix_acl_access", nullptr, 0, 0, XATTR_NOFOLLOW) >= 0 || errno == ENODATA;
 #endif
     return fileSystemSupportsACLs;
 }
