require "formula"

class Kf5Kguiaddons < Formula
  url "http://download.kde.org/unstable/frameworks/4.98.0/kguiaddons-4.98.0.tar.xz"
  sha1 "1ca82175e5f5ad826c525214fa162a5a063b6a65"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kguiaddons.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"

  def patches
    if not build.head?
      DATA
    end
  end

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end

__END__
diff --git a/src/colors/kcolorutils.cpp b/src/colors/kcolorutils.cpp
index f7779b8..3f4f1c8 100644
--- a/src/colors/kcolorutils.cpp
+++ b/src/colors/kcolorutils.cpp
@@ -26,6 +26,8 @@
 #include <QImage>
 #include <QtNumeric> // qIsNaN
 
+#include <math.h>
+
 // BEGIN internal helper functions
 static inline qreal mixQreal(qreal a, qreal b, qreal bias)
 {
