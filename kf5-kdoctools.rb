require "formula"

class Kf5Kdoctools < Formula
  url "http://download.kde.org/stable/frameworks/5.1.0/kdoctools-5.1.0.tar.xz"
  sha1 "49fbc6ff3361ee99e3fccba68f9740c2c4fe7b50"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kdoctools.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"
  depends_on "docbook"
  depends_on "docbook-xsl"

  def patches
    DATA
  end

  def install
    args = std_cmake_args

    args << "-DDocBookXML_CURRENTDTD_DIR:PATH=#{Formula.factory('docbook').prefix}/docbook/xml/4.2"
    args << "-DDocBookXSL_DIR:PATH=#{Formula.factory('docbook-xsl').prefix}/docbook-xsl"

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end

__END__
diff --git a/cmake/FindDocBookXML4.cmake b/cmake/FindDocBookXML4.cmake
index 415745f..4d7f089 100644
--- a/cmake/FindDocBookXML4.cmake
+++ b/cmake/FindDocBookXML4.cmake
@@ -34,6 +34,7 @@ function (locate_version version found_dir)
         share/xml/docbook/xml-dtd-${version}
         share/sgml/docbook/xml-dtd-${version}
         share/xml/docbook/${version}
+        opt/docbook/docbook/xml/${version}
     )
 
     find_path (searched_dir docbookx.dtd
diff --git a/src/docbookl10nhelper.cpp b/src/docbookl10nhelper.cpp
index 6eecb37..fc98f74 100644
--- a/src/docbookl10nhelper.cpp
+++ b/src/docbookl10nhelper.cpp
@@ -206,7 +206,7 @@ int main(int argc, char **argv)
     QStringList dirFileFilters;
     dirFileFilters << QStringLiteral("*.xml");
     QStringList customLangFiles = outDir.entryList(dirFileFilters,
-                                  QDir::Files | QDir::NoSymLinks, QDir::Name);
+                                  QDir::Files, QDir::Name);
     /* the following two calls to removeOne should not be needed, as
      * the customization directory from the sources should not contain
      * those files
diff --git a/src/xslt.cpp b/src/xslt.cpp
index 3c81a17..303ca32 100644
--- a/src/xslt.cpp
+++ b/src/xslt.cpp
@@ -423,7 +423,7 @@ QStringList getKDocToolsCatalogs()
         QDir customizationDir = QDir(customizationDirName);
         const QStringList catalogFileFilters(QStringLiteral("catalog*.xml"));
         const QFileInfoList catalogInfoFiles = customizationDir.entryInfoList(catalogFileFilters,
-                                               QDir::Files | QDir::NoSymLinks, QDir::Name);
+                                               QDir::Files, QDir::Name);
         foreach (const QFileInfo &fileInfo, catalogInfoFiles) {
             const QString fullFileName = QUrl::fromLocalFile(fileInfo.absoluteFilePath()).toEncoded();
             if (fileInfo.fileName() == QStringLiteral("catalog.xml")) {
