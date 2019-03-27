class QtWebkit < Formula
  desc "Classes for a WebKit2 based implementation and a new QML API"
  homepage "https://www1.qt.io/developers/"
  url "https://github.com/qt/qtwebkit/archive/v5.212.0-alpha2.tar.gz"
  sha256 "6db43b931f64857cfda7bcf89914e2730b82164871a8c24c1881620e6bfdeca1"

  revision 4
  head "https://github.com/qt/qtwebkit.git"

  depends_on "cmake" => :build
  depends_on "fontconfig" => :build
  depends_on "freetype" => :build
  depends_on "gperf" => :build
  depends_on "ninja" => :build
  depends_on "sqlite" => :build
  depends_on "libxslt"
  depends_on "qt"
  depends_on "webp"
  depends_on "zlib"

  patch :DATA

  patch do
    # Fix null point dereference (Fedora) https://github.com/annulen/webkit/issues/573
    url "https://git.archlinux.org/svntogit/packages.git/plain/trunk/qt5-webkit-null-pointer-dereference.patch?h=packages/qt5-webkit"
    sha256 "510e1f78c2bcd76909703a097dbc1d5c9c6ce4cd94883c26138f09cc10121f43"
  end
  patch do
    # Fix build with cmake 3.10
    url "https://github.com/annulen/webkit/commit/f51554bf104ab0491370f66631fe46143a23d5c2.diff?full_index=1"
    sha256 "874b56c30cdc43627f94d999083f0617c4bfbcae4594fe1a6fc302bf39ad6c30"
  end

  def cmake_args
    args = %W[
      -DCMAKE_INSTALL_PREFIX=#{prefix}
      -DCMAKE_BUILD_TYPE=Release
      -DCMAKE_FIND_FRAMEWORK=LAST
      -DCMAKE_VERBOSE_MAKEFILE=ON
      -Wno-dev
    ]
    args
  end

  def install
    args = cmake_args
    args << "-DPORT=Qt"
    args << "-DENABLE_TOOLS=OFF"
    args << "-DCMAKE_MACOSX_RPATH=OFF"
    args << "-DEGPF_SET_RPATH=OFF"
    args << "-DCMAKE_SKIP_RPATH=ON"
    args << "-DCMAKE_SKIP_INSTALL_RPATH=ON"

    # Fuck up rpath
    inreplace "Source/cmake/OptionsQt.cmake", "RPATH\ ON", "RPATH\ OFF"
    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end
end

__END__
--- a/Source/WTF/wtf/spi/darwin/XPCSPI.h 2017-06-17 13:46:54.000000000 +0300
+++ b/Source/WTF/wtf/spi/darwin/XPCSPI.h 2018-09-08 23:41:06.397523110 +0300
@@ -89,10 +89,6 @@
 EXTERN_C const struct _xpc_type_s _xpc_type_string;

 EXTERN_C xpc_object_t xpc_array_create(const xpc_object_t*, size_t count);
-#if COMPILER_SUPPORTS(BLOCKS)
-EXTERN_C bool xpc_array_apply(xpc_object_t, xpc_array_applier_t);
-EXTERN_C bool xpc_dictionary_apply(xpc_object_t xdict, xpc_dictionary_applier_t applier);
-#endif
 EXTERN_C size_t xpc_array_get_count(xpc_object_t);
 EXTERN_C const char* xpc_array_get_string(xpc_object_t, size_t index);
 EXTERN_C void xpc_array_set_string(xpc_object_t, size_t index, const char* string);
