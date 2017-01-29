require "formula"

class Kf5Kdoctools < Formula
  url "http://download.kde.org/stable/frameworks/5.30/kdoctools-5.30.0.tar.xz"
  sha256 "7e4f16bd55b9de0afbc338dc923bb7c5f4f3b6541ccd72dfc10b624eab732792"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kdoctools.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-karchive"
  depends_on "qt5"
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
    So that "kf5/kdoctools/customization" can be found when building other kf5 modules.

    This symlink can be removed when this formula is uninstalled.
    EOS
  end
end

__END__
diff --git a/cmake/FindDocBookXML4.cmake b/cmake/FindDocBookXML4.cmake
index f56483b..8b1eb01 100644
--- a/cmake/FindDocBookXML4.cmake
+++ b/cmake/FindDocBookXML4.cmake
@@ -55,6 +55,7 @@ function (locate_version version found_dir)
         ${CMAKE_INSTALL_DATAROOTDIR}/xml/docbook/xml-dtd-${version}
         ${CMAKE_INSTALL_DATAROOTDIR}/sgml/docbook/xml-dtd-${version}
         ${CMAKE_INSTALL_DATAROOTDIR}/xml/docbook/${version}
+        opt/docbook/docbook/xml/${version}
     )
 
     find_path (searched_dir docbookx.dtd
