require "formula"

class Kf5Kinit < Formula
  url "http://download.kde.org/stable/frameworks/5.40/kinit-5.40.0.tar.xz"
  sha256 "ca97eb8480a7387537166831a6a91892068656a161b9726429af581a436e2689"
  desc "Process launcher to speed up launching KDE applications"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kinit.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kio"
  depends_on "qt"

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
diff --git a/src/kdeinit/CMakeLists.txt b/src/kdeinit/CMakeLists.txt
index f00dd77..6c5f593 100644
--- a/src/kdeinit/CMakeLists.txt
+++ b/src/kdeinit/CMakeLists.txt
@@ -3,6 +3,7 @@ if (WIN32)
   set(kdeinit_LIBS psapi)
 elseif (APPLE)
   set(kdeinit_SRCS kinit.cpp kinit_mac.mm proctitle.cpp ../klauncher_cmds.cpp )
+  set_source_files_properties(kinit_mac.mm PROPERTIES COMPILE_DEFINITIONS QT_NO_EXCEPTIONS)
   set(kdeinit_LIBS "")
 else ()
   set(kdeinit_SRCS kinit.cpp proctitle.cpp ../klauncher_cmds.cpp )
