require "formula"

class Kf5Kconfig < Formula
  url "http://download.kde.org/stable/frameworks/5.40/kconfig-5.40.0.tar.xz"
  sha256 "6b96654c525de124fe127f4d40e0ff8e99a1d31ef7b368de7ce3af876b55295f"
  desc "Configuration system"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kconfig.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
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
diff --git a/src/kconfig_compiler/CMakeLists.txt b/src/kconfig_compiler/CMakeLists.txt
index 368a4d8..004a649 100644
--- a/src/kconfig_compiler/CMakeLists.txt
+++ b/src/kconfig_compiler/CMakeLists.txt
@@ -20,4 +20,6 @@ find_package(Qt5Xml ${REQUIRED_QT_VERSION} REQUIRED NO_MODULE)
 
 target_link_libraries(kconfig_compiler Qt5::Xml)
 
+ecm_mark_nongui_executable(kconfig_compiler)
+
 install(TARGETS kconfig_compiler EXPORT KF5ConfigCompilerTargets DESTINATION ${KDE_INSTALL_LIBEXECDIR_KF5})
