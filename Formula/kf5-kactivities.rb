class Kf5Kactivities < Formula
  desc "Core components for the KDE's Activities"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.58/kactivities-5.58.0.tar.xz"
  sha256 "5295cfdc392a8146ca9c3822f1250ceaf5b54990d69c2e3dec4b072519a5ce5b"

  head "git://anongit.kde.org/kactivities.git"

  depends_on "boost" => :build
  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "ninja" => :build

  depends_on "KDE-mac/kde/kf5-kconfig"
  depends_on "KDE-mac/kde/kf5-kcoreaddons"
  depends_on "KDE-mac/kde/kf5-kwindowsystem"

  patch :DATA

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"
    args << "-DKDE_INSTALL_QTPLUGINDIR=lib/qt5/plugins"

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Activities REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end

# Mark executables as nongui type

__END__
diff --git a/src/cli/CMakeLists.txt b/src/cli/CMakeLists.txt
index d0e13be..479031b 100644
--- a/src/cli/CMakeLists.txt
+++ b/src/cli/CMakeLists.txt
@@ -30,6 +30,8 @@ target_link_libraries (
    KF5::Activities
    )
 
+ecm_mark_nongui_executable(kactivities-cli)
+
 install (TARGETS
    kactivities-cli
    ${KF5_INSTALL_TARGETS_DEFAULT_ARGS}
