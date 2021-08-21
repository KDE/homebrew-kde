require_relative "../lib/cmake"

class Kf5PlasmaFramework < Formula
  desc "Plasma library and runtime components based upon KF5 & Qt5"
  homepage "https://api.kde.org/frameworks/plasma-framework/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.85/plasma-framework-5.85.0.tar.xz"
  sha256 "879b3a97ec1a43a7108a2469e5d23578f05b1afcd838b286576ca5a14fadf8ff"
  head "https://invent.kde.org/frameworks/plasma-framework.git"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "gettext" => :build
  depends_on "graphviz" => :build
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kactivities"
  depends_on "kde-mac/kde/kf5-kdeclarative"
  depends_on "kde-mac/kde/kf5-kirigami2"

  patch :DATA

  def install
    args = kde_cmake_args

    system "cmake", *args
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
    (testpath/"CMakeLists.txt").write <<~EOS
      find_package(KF5Plasma REQUIRED)
      find_package(KF5PlasmaQuick REQUIRED)
    EOS
    system "cmake", ".", "-Wno-dev"
  end
end

# Mark executables as nongui type

__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index fb7b76b..71ee8a4 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -25,6 +25,7 @@ include(ECMAddQch)
 include(KDEPackageAppTemplates)
 include(ECMGenerateQmlTypes)
 include(ECMSetupQtPluginMacroNames)
+include(ECMMarkNonGuiExecutable)

 option(BUILD_QCH "Build API documentation in QCH format (for e.g. Qt Assistant, Qt Creator & KDevelop)" OFF)
 add_feature_info(QCH ${BUILD_QCH} "API documentation in QCH format (for e.g. Qt Assistant, Qt Creator & KDevelop)")
diff --git a/src/plasmapkg/CMakeLists.txt b/src/plasmapkg/CMakeLists.txt
index 6247f92..20186d7 100644
--- a/src/plasmapkg/CMakeLists.txt
+++ b/src/plasmapkg/CMakeLists.txt
@@ -2,5 +2,6 @@ add_executable(plasmapkg2 main.cpp)

 target_link_libraries(plasmapkg2 Qt5::Core)

+ecm_mark_nongui_executable(plasmapkg2)
 install(TARGETS plasmapkg2 ${KF5_INSTALL_TARGETS_DEFAULT_ARGS})


