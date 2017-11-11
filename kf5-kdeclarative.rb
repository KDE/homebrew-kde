require "formula"

class Kf5Kdeclarative < Formula
  url "http://download.kde.org/stable/frameworks/5.40/kdeclarative-5.40.0.tar.xz"
  sha256 "a60142c4c1b14756196ebb90db63fd1214efe8ed921afa8b6b956caed23bd783"
  desc "Provides integration of QML and KDE Frameworks"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kdeclarative.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kio"
  depends_on "KDE-mac/kde/kf5-kpackage"
  depends_on "qt"
  depends_on "libepoxy"

  patch :DATA

  def install
    args = std_cmake_args
    args << "-DCMAKE_INSTALL_BUNDLEDIR=#{prefix}/bin" 

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end

  def caveats; <<-EOS.undent
    You need to take some manual steps in order to make this formula work:
      mkdir -p "$HOME/Applications/KDE"
      ln -sf "#{prefix}/bin/kpackagelauncherqml.app" "$HOME/Applications/KDE"
    EOS
  end
end

__END__
diff --git a/src/qmlcontrols/kquickcontrolsaddons/plotter.cpp b/src/qmlcontrols/kquickcontrolsaddons
index 67ce63a..22934ad 100644
--- a/src/qmlcontrols/kquickcontrolsaddons/plotter.cpp
+++ b/src/qmlcontrols/kquickcontrolsaddons/plotter.cpp
@@ -47,6 +47,8 @@
 
 #include <QuickAddons/ManagedTextureNode>
 
+#include <cmath>
+
 //completely arbitrary
 static int s_defaultSampleSize = 40;

