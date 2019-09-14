class Kf5Kross < Formula
  desc "Embedding of scripting into applications"
  homepage "https://api.kde.org/frameworks/kross/html"
  url "https://download.kde.org/stable/frameworks/5.62/portingAids/kross-5.62.0.tar.xz"
  sha256 "38bf9a57f181d823974a00896d89ae7106488c2ccbd7179e295d297edb338563"
  head "git://anongit.kde.org/kross.git"

  depends_on "cmake" => :build
  depends_on "gettext" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "KDE-mac/kde/kf5-kparts"

  patch :DATA

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
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
    assert `"#{bin}"/kf5kross --help | grep -- --help` =~ /--help/
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Kross REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end

# Mark executable as nongui type

__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index c729c33..aaeb1df 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -20,6 +20,8 @@ include(ECMGenerateHeaders)

 include(ECMQtDeclareLoggingCategory)

+include(ECMMarkNonGuiExecutable)
+
 include(KDEInstallDirs)
 include(KDEFrameworkCompilerSettings NO_POLICY_SCOPE)
 include(KDECMakeSettings)
diff --git a/src/console/CMakeLists.txt b/src/console/CMakeLists.txt
index 8e15a1a..6808f52 100644
--- a/src/console/CMakeLists.txt
+++ b/src/console/CMakeLists.txt
@@ -7,4 +7,5 @@ target_link_libraries(kf5kross
    Qt5::Widgets
 )

+ecm_mark_nongui_executable(kf5kross)
 install(TARGETS kf5kross ${KF5_INSTALL_TARGETS_DEFAULT_ARGS})
