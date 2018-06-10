class Kf5PlasmaFramework < Formula
  desc "Plasma library and runtime components based upon KF5 & Qt5"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.47/plasma-framework-5.47.0.tar.xz"
  sha256 "4a43bb699e2d6e004b0d218c98079eea329d3a2d3de82b33b7d298e4cb146eb4"

  head "git://anongit.kde.org/plasma-framework.git"

  depends_on "cmake" => :build
  depends_on "gettext" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build

  depends_on "KDE-mac/kde/kf5-kactivities"
  depends_on "KDE-mac/kde/kf5-kdeclarative"
  depends_on "KDE-mac/kde/kf5-kirigami2"

  # Mark executables as nongui type
  patch :DATA

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"
    args << "-DCMAKE_INSTALL_BUNDLEDIR=#{bin}"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end

  def caveats; <<~EOS
    You need to take some manual steps in order to make this formula work:
      ln -sf "$(brew --prefix)/share/kdevappwizard" "$HOME/Library/Application Support"
      ln -sf "$(brew --prefix)/share/kservices5" "$HOME/Library/Application Support"
      ln -sf "$(brew --prefix)/share/kservicetypes5" "$HOME/Library/Application Support"
      ln -sf "$(brew --prefix)/share/plasma" "$HOME/Library/Application Support"
    EOS
  end
end

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


