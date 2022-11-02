require_relative "../lib/cmake"

class Kf5Kwallet < Formula
  desc "Secure and unified container for user passwords"
  homepage "https://api.kde.org/frameworks/kwallet/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.99/kwallet-5.99.0.tar.xz"
  sha256 "d2c66b736872563a7ce4db5765325ecf5ec07c8f296e7160946bccefcce02a07"
  head "https://invent.kde.org/frameworks/kwallet.git", branch: "master"

  depends_on "boost" => :build
  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "gettext" => :build
  depends_on "graphviz" => :build
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "gpgme"
  depends_on "kde-mac/kde/kf5-kiconthemes"
  depends_on "kde-mac/kde/kf5-knotifications"
  depends_on "kde-mac/kde/kf5-kservice"
  depends_on "libgcrypt"
  depends_on "qca"

  patch :DATA

  def install
    args = "-DCMAKE_CXX_FLAGS=-I#{Formula["libgpg-error"].include}"

    system "cmake", *kde_cmake_args, args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  def caveats
    <<~EOS
      You need to take some manual steps in order to make this formula work:
        "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
    EOS
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Wallet REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end

# Mark executables as nongui type, merged
__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 73e71c7..0e301da 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -26,6 +26,7 @@ include(ECMAddQch)
 include(ECMGenerateExportHeader)
 include(ECMSetupVersion)
 include(ECMQtDeclareLoggingCategory)
+include(ECMMarkNonGuiExecutable)
 
 option(BUILD_KWALLETD "Build the kwallet daemon" ON)
 option(BUILD_KWALLET_QUERY "Build kwallet-query tool" ON)
diff --git a/src/runtime/kwallet-query/src/CMakeLists.txt b/src/runtime/kwallet-query/src/CMakeLists.txt
index 4705e68..f010ec1 100644
--- a/src/runtime/kwallet-query/src/CMakeLists.txt
+++ b/src/runtime/kwallet-query/src/CMakeLists.txt
@@ -15,4 +15,5 @@ TARGET_LINK_LIBRARIES(kwallet-query
     Qt${QT_MAJOR_VERSION}::Widgets
 )
 
+ecm_mark_nongui_executable(kwallet-query)
 install( TARGETS kwallet-query DESTINATION ${KDE_INSTALL_TARGETS_DEFAULT_ARGS})
diff --git a/src/runtime/kwalletd/CMakeLists.txt b/src/runtime/kwalletd/CMakeLists.txt
index 65c9fa7..2ba7e67 100644
--- a/src/runtime/kwalletd/CMakeLists.txt
+++ b/src/runtime/kwalletd/CMakeLists.txt
@@ -150,6 +150,7 @@ if (Gpgmepp_FOUND)
     kde_target_enable_exceptions(kwalletd5 PRIVATE)
 endif(Gpgmepp_FOUND)
 
+ecm_mark_nongui_executable(kwalletd5)
 install(TARGETS kwalletd5  ${KF_INSTALL_TARGETS_DEFAULT_ARGS})
 
 ########### install files ###############
