require "formula"

class Kf5Sonnet < Formula
  url "http://download.kde.org/stable/frameworks/5.36/sonnet-5.36.0.tar.xz"
  sha256 "accf0724615abf684258fa087e4166e803385ec4190f92c792fd16e8189366ed"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/sonnet.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt"

  patch :DATA

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end

__END__
diff --git a/src/plugins/nsspellchecker/CMakeLists.txt b/src/plugins/nsspellchecker/CMakeLists.txt
index f8c99d1..f2fa4a9 100644
--- a/src/plugins/nsspellchecker/CMakeLists.txt
+++ b/src/plugins/nsspellchecker/CMakeLists.txt
@@ -7,6 +7,8 @@ add_library(sonnet_nsspellchecker MODULE ${sonnet_nsspellchecker_PART_SRCS})
 
 target_link_libraries(sonnet_nsspellchecker PRIVATE KF5::SonnetCore "-framework Cocoa")
 
+target_compile_definitions(sonnet_nsspellchecker PRIVATE "QT_NO_EXCEPTIONS")
+
 set_target_properties(sonnet_nsspellchecker PROPERTIES OUTPUT_NAME "nsspellchecker")
 install(TARGETS sonnet_nsspellchecker  DESTINATION ${KDE_INSTALL_PLUGINDIR}/kf5/sonnet/)
 
