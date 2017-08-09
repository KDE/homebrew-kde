require "formula"

class Kf5Kdeclarative < Formula
  url "http://download.kde.org/stable/frameworks/5.36/kdeclarative-5.36.0.tar.xz"
  sha256 "2dde12110310cbb980381fd51c0926f2f5cf202760a0a871a01a2412080a5d52"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kdeclarative.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt"
  depends_on "libepoxy"
  depends_on "haraldf/kf5/kf5-kio"
  depends_on "haraldf/kf5/kf5-kpackage"

  patch :DATA

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
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

