require "formula"

class Kf5Kdelibs4support < Formula
  url "http://download.kde.org/stable/frameworks/5.16/portingAids/kdelibs4support-5.16.0.tar.xz"
  sha1 "13c9a91465541ad3f7e915fa732db9740ea15522"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kdelibs4support.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kdoctools" => :build
  depends_on "qt5" => "with-dbus"
  depends_on "haraldf/kf5/kf5-kdesignerplugin"
  depends_on "haraldf/kf5/kf5-kemoticons"
  depends_on "haraldf/kf5/kf5-kinit"
  depends_on "haraldf/kf5/kf5-kitemmodels"
  depends_on "haraldf/kf5/kf5-kunitconversion"

  def patches
    DATA
  end

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end

__END__
diff --git a/src/kssl/ksslcertificate.cpp b/src/kssl/ksslcertificate.cpp
index 89c5e28..03ffdcd 100644
--- a/src/kssl/ksslcertificate.cpp
+++ b/src/kssl/ksslcertificate.cpp
@@ -1017,7 +1017,7 @@ QDateTime KSSLCertificate::getQDTNotAfter() const
 
 int operator==(KSSLCertificate &x, KSSLCertificate &y)
 {
-#ifndef KSSL_HAVE_SSL
+#if !KSSL_HAVE_SSL
     return 1;
 #else
     if (!KOSSL::self()->X509_cmp(x.getCert(), y.getCert())) {
