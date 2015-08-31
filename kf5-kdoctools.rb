require "formula"

class Kf5Kdoctools < Formula
  url "http://download.kde.org/stable/frameworks/5.10/kdoctools-5.10.0.tar.xz"
  sha1 "27d0bf5a8280eb22f48444bda691327e9d71bcdf"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kdoctools.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-karchive"
  depends_on "qt5" => "with-d-bus"
  depends_on "docbook"
  depends_on "docbook-xsl"
  depends_on "gettext"

  def patches
    DATA
  end

  def install
    args = std_cmake_args

    args << "-DDocBookXML_CURRENTDTD_DIR:PATH=#{Formula.factory('docbook').prefix}/docbook/xml/4.2"
    args << "-DDocBookXSL_DIR:PATH=#{Formula.factory('docbook-xsl').prefix}/docbook-xsl"

    system "cmake", ".", *args
    system "make", "install"
    ln_s Dir["#{share}/kf5"], "#{Etc.getpwuid.dir}/Library/Application Support/", :force => true
    prefix.install "install_manifest.txt"
  end
  def caveats; <<-EOS.undent
    A symlink "#{ENV['HOME']}/Library/Application Support/kf5" was created
    So that "kf5/kdoctools/customization" can be found when building other kf5 stuff.
    
    This symlink can be removed when this formula is uninstalled.
    EOS
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
