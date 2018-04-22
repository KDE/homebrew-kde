class Kf5Ki18n < Formula
  desc "Advanced internationalization framework"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.45/ki18n-5.45.0.tar.xz"
  sha256 "b70e62cd355b02c6160b69b210fd7f4bd44fb341e013db8dc81c744332e55cf6"
  version "5.45.0-1" # Remove version number and patch when upgrading to 5.46.0

  head "git://anongit.kde.org/ki18n.git"

  depends_on "cmake" => :build
  depends_on "gettext" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "qt"

  # This patch is already in upstream and should be removed for the next
  # stable version, but without this patch we cannot build any KDE
  # applications that depend on this package because while building it will
  # hit the maximum number of proecesses per user limit and crash the system
  stable do
    patch :DATA
  end

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"
    args << "-DCMAKE_SHARED_LINKER_FLAGS=-lintl" # cmake thinks libintl is part of libc
    args << "-DCMAKE_EXE_LINKER_FLAGS=-lintl"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end

__END__
diff --git a/cmake/build-pofiles.cmake b/cmake/build-pofiles.cmake
index d0991ad..b39be31 100644
--- a/cmake/build-pofiles.cmake
+++ b/cmake/build-pofiles.cmake
@@ -62,6 +62,7 @@ foreach(pofile IN LISTS pofiles)
     if(i EQUAL ${numberOfProcesses})
         _processCommands()
         set(i 0)
+        set(commands)
     endif()
 endforeach()
