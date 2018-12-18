class Kf5Kglobalaccel < Formula
  desc "Add support for global workspace shortcuts"
  homepage "https://www.kde.org"
  head "git://anongit.kde.org/kglobalaccel.git"

  stable do
    url "https://download.kde.org/stable/frameworks/5.53/kglobalaccel-5.53.0.tar.xz"
    sha256 "11f32165d3d457e1eb1948bdab24c4bf89484223842893a589e4df04069dc0c0"
    patch :DATA
  end

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "KDE-mac/kde/kf5-kconfig"
  depends_on "KDE-mac/kde/kf5-kcrash"
  depends_on "KDE-mac/kde/kf5-kdbusaddons"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end

  def caveats; <<~EOS
    You need to take some manual steps in order to make this formula work:
      ln -sfv "$(brew --prefix)/share/kservices5" "$HOME/Library/Application Support"
  EOS
  end
end

__END__
diff --git a/src/runtime/plugins/CMakeLists.txt b/src/runtime/plugins/CMakeLists.txt
--- a/src/runtime/plugins/CMakeLists.txt
+++ b/src/runtime/plugins/CMakeLists.txt
@@ -1,4 +1,4 @@
-if (${XCB_XCB_FOUND} AND ${XCB_KEYSYMS_FOUND} AND ${XCB_XKB_FOUND})
+if (XCB_XCB_FOUND AND XCB_KEYSYMS_FOUND AND XCB_XKB_FOUND)
     add_subdirectory(xcb)
 endif()
 # if (APPLE)
