class Atcore < Formula
  desc "API to manage the connection to 3D Printers"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/atcore/1.0.0/atcore-1.0.0.tar.xz"
  sha256 "ffd12455c9b8db853e455a437d6c6b601e0003c6732bbc6c2828032e004530e2"

  head "git://anongit.kde.org/atcore.git"
  option "with-gui", "Build atcore-gui (HEAD ONLY)" 

  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "cmake" => :build
  depends_on "qt"
  
  head do
    patch :DATA
  end
  
  def install
    args = std_cmake_args
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"
    if build.with?("gui")
         args << "-DBUILD_GUI=ON"
    end

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end

__END__

diff --git a/src/atcore.cpp b/src/atcore.cpp
index fe4ea2c..8e60577 100644
--- a/src/atcore.cpp
+++ b/src/atcore.cpp
@@ -84,8 +84,15 @@ AtCore::AtCore(QObject *parent) :
     //Attempt to find our plugins
     //For Windows and Mac we always look in plugins folder of the program using atcore.
     //On others we use AtCoreDirectories::pluginDir to hold a list of dirs to check
-#if defined(Q_OS_WIN) || defined(Q_OS_MAC)
-    d->pluginsDir = qApp->applicationDirPath() + QStringLiteral("/plugins");
+#if defined(Q_OS_MAC)
+    QString path = AtCoreDirectories::pluginDir.at(2);
+    int cellarpos = path.indexOf(QStringLiteral("Cellar"));
+    int end = path.length() - cellarpos;
+    path = path.remove(cellarpos, end);
+    QString temp = AtCoreDirectories::pluginDir.at(1);
+    temp.prepend(path);
+    d->pluginsDir = temp;
+    qDebug() << path << temp;
 #else
     for (const auto &path : AtCoreDirectories::pluginDir) {
         qCDebug(ATCORE_PLUGIN) << "Lookin for plugins in " << path;
diff --git a/src/plugins/CMakeLists.txt b/src/plugins/CMakeLists.txt
index 7d1d68e..423bb35 100644
--- a/src/plugins/CMakeLists.txt
+++ b/src/plugins/CMakeLists.txt
@@ -29,7 +29,7 @@ set(SmoothiePlugin_SRCS smoothieplugin.cpp)
 add_library(smoothie SHARED ${SmoothiePlugin_SRCS})
 target_link_libraries(smoothie Qt5::Core AtCore::AtCore)
 
-if(WIN32 OR APPLE)
+if(WIN32)
     install(
     TARGETS
         repetier
@@ -44,7 +44,7 @@ if(WIN32 OR APPLE)
     )
 endif()
 
-if(UNIX AND NOT APPLE) 
+if (UNIX)
     install(
     TARGETS
         repetier
