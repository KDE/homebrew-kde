require "formula"

class Kf5Konversation < Formula
  desc "A user-friendly and fully-featured IRC client"
  homepage "http://www.kde.org/"
  url "http://download.kde.org/unstable/konversation/1.6-beta1/src/konversation-1.6-beta1.tar.xz"
  sha256 "7c818eb5d74e84847e66849785eb3f52d50ba8dc0a80d00cb5ab1b852135b431"

  head "git://anongit.kde.org/konversation.git", :branch => "master"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-karchive"
  depends_on "KDE-mac/kde/kf5-kbookmarks"
  depends_on "KDE-mac/kde/kf5-kconfig"
  depends_on "KDE-mac/kde/kf5-kconfigwidgets"
  depends_on "KDE-mac/kde/kf5-kdoctools"
  depends_on "KDE-mac/kde/kf5-kemoticons"
  depends_on "KDE-mac/kde/kf5-ki18n"
  depends_on "KDE-mac/kde/kf5-kidletime"
  depends_on "KDE-mac/kde/kf5-knotifyconfig"
  depends_on "KDE-mac/kde/kf5-kio"
  depends_on "KDE-mac/kde/kf5-kparts"
  depends_on "KDE-mac/kde/kf5-solid"
  depends_on "KDE-mac/kde/kf5-sonnet"
  depends_on "KDE-mac/kde/kf5-kwallet"
  depends_on "KDE-mac/kde/kf5-kwidgetsaddons"
  depends_on "KDE-mac/kde/kf5-kglobalaccel"
  depends_on "qt"
  depends_on "qca" => :optional # must built with qt5

  # patch :DATA

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
      ln -sf "#{prefix}/bin/konversation.app" "$HOME/Applications/KDE"
    EOS
  end
end

__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index e25a4b7..98258c0 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -91,7 +91,7 @@ add_definitions(
 
 # helper libs
 add_subdirectory( libs )
-add_subdirectory( doc )
+#add_subdirectory( doc )
 
 set( OKTETALIBS_MAJOR_VERSION 0 )
 set( OKTETALIBS_MINOR_VERSION 9 )
