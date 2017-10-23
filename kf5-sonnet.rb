require "formula"

class Kf5Sonnet < Formula
  desc "Spelling framework for Qt5"
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.39/sonnet-5.39.0.tar.xz"
  sha256 "819f2bf8c95758106deaf800f3c4ec18d3f42d845a90996462839a759774abac"

  head "git://anongit.kde.org/sonnet.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt"

  # TODO: figure out how to properly fix https://github.com/haraldF/homebrew-kf5/issues/72
  conflicts_with "hunspell"

  patch :DATA

  def install
    args = std_cmake_args

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
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
 
