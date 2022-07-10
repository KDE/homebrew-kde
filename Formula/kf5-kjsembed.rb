require_relative "../lib/cmake"

class Kf5Kjsembed < Formula
  desc "Embedded JS"
  homepage "https://api.kde.org/frameworks/kjsembed/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.96/portingAids/kjsembed-5.96.0.tar.xz"
  sha256 "000ee3f2965f8f783e0e54f526fc505686b45c833f53d73515fae1b0890510fd"
  head "https://invent.kde.org/frameworks/kjsembed.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "gettext" => :build
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kjs"
  depends_on "ki18n"

  patch :DATA

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5JsEmbed REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end

# Mark executable as nongui type
# https://invent.kde.org/frameworks/kjsembed/-/merge_requests/4
__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 85973b9..a45ad84 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -20,6 +20,7 @@ include(ECMGenerateHeaders)
 include(ECMDeprecationSettings)
 include(GenerateExportHeader)
 include(CMakePackageConfigHelpers)
+include(ECMMarkNonGuiExecutable)
 
 set(REQUIRED_QT_VERSION 5.15.2)
 find_package(Qt5 "${REQUIRED_QT_VERSION}" CONFIG REQUIRED UiTools Widgets Xml Svg)
diff --git a/src/kjscmd/CMakeLists.txt b/src/kjscmd/CMakeLists.txt
index 3272269..4d599e8 100644
--- a/src/kjscmd/CMakeLists.txt
+++ b/src/kjscmd/CMakeLists.txt
@@ -13,4 +13,5 @@ target_link_libraries(kjscmd5
     KF5::JsEmbed
 )
 
+ecm_mark_nongui_executable(kjscmd5)
 install(TARGETS kjscmd5 ${KF5_INSTALL_TARGETS_DEFAULT_ARGS})
