require "formula"

class Kf5Kdesu < Formula
  url "http://download.kde.org/stable/frameworks/5.8/kdesu-5.8.0.tar.xz"
  sha1 "42c74327f5c9f7adc981120e1521816396853ddc"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kdesu.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kpty"
  depends_on "qt5" => "with-d-bus"
  depends_on "gettext" => :build

  def patches
    DATA
  end

  def install
    args = std_cmake_args
    args << "-DCMAKE_CXX_FLAGS='-D_DARWIN_C_SOURCE'"

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end

__END__
diff -Nu a/CMakeLists.txt a/CMakeLists.txt.new
--- a/CMakeLists.txt	2015-03-07 22:41:59.000000000 +0800
+++ a/CMakeLists.txt.new	2015-03-14 23:08:17.000000000 +0800
@@ -18,10 +18,6 @@
 find_package(KF5Service ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5Pty ${KF5_DEP_VERSION} REQUIRED)
 
-#optional features
-find_package(X11)
-set(HAVE_X11 ${X11_FOUND})
-
 include(FeatureSummary)
 include(GenerateExportHeader)
 include(ECMSetupVersion)
