require_relative "../lib/cmake"

class Ksysguard < Formula
  desc "Track and control the processes running in your system"
  homepage "https://apps.kde.org/ksysguard"
  url "https://download.kde.org/stable/ksysguard/5.22.0/ksysguard-5.22.0.tar.xz"
  sha256 "0f9c624e5fbb2aee906d8d9563c5a7eb09eaf38bc8e4382c072f9e6d8854622d"
  head "https://invent.kde.org/plasma/ksysguard.git", branch: "master"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "kde-mac/kde/kf5-plasma-framework" => :build
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "hicolor-icon-theme"
  depends_on "kde-mac/kde/kf5-kinit"
  depends_on "kde-mac/kde/kf5-knewstuff"
  depends_on "kde-mac/kde/libksysguard"

  patch :DATA

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
    # Extract Qt plugin path
    qtpp = `#{Formula["qt@5"].bin}/qtpaths --plugin-dir`.chomp
    system "/usr/libexec/PlistBuddy",
      "-c", "Add :LSEnvironment:QT_PLUGIN_PATH string \"#{qtpp}\:#{HOMEBREW_PREFIX}/lib/qt5/plugins\"",
      "#{bin}/ksysguard.app/Contents/Info.plist"
  end

  def post_install
    mkdir_p HOMEBREW_PREFIX/"share/ksysguard"
    ln_sf HOMEBREW_PREFIX/"share/icons/breeze/breeze-icons.rcc", HOMEBREW_PREFIX/"share/ksysguard/icontheme.rcc"
  end

  def caveats
    <<~EOS
      You need to take some manual steps in order to make this formula work:
        "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
    EOS
  end

  test do
    assert_match "help", shell_output("#{bin}/ksysguard.app/Contents/MacOS/ksysguard --help")
  end
end

# Mark executable as nongui type

__END__
diff --git a/CMakeLists copia.txt b/CMakeLists.txt
index f24243f..a23b2dc 100644
--- a/CMakeLists copia.txt	
+++ b/CMakeLists.txt
@@ -18,6 +18,7 @@ include(KDECMakeSettings)
 include(KDECompilerSettings NO_POLICY_SCOPE)
 include(ECMAddTests)
 include(ECMInstallIcons)
+include(ECMMarkNonGuiExecutable)
 include(FeatureSummary)
 
 find_package(Qt5 ${QT_MIN_VERSION} CONFIG REQUIRED COMPONENTS
diff --git a/ksysguardd/CMakeLists copia.txt b/ksysguardd/CMakeLists.txt
index 31f29d7..9f87edb 100644
--- a/ksysguardd/CMakeLists copia.txt	
+++ b/ksysguardd/CMakeLists.txt
@@ -60,4 +60,5 @@ if( ${CMAKE_SYSTEM_NAME} MATCHES "SunOS" )
   target_link_libraries(ksysguardd socket nsl)
 endif()
 
+ecm_mark_nongui_executable(ksysguardd)
 install(TARGETS ksysguardd ${KDE_INSTALL_TARGETS_DEFAULT_ARGS})
