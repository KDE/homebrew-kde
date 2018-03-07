class Kdevelop < Formula
  desc "Integrated Development Environment for KDE"
  homepage "https://kdevelop.org"
  url "https://download.kde.org/stable/kdevelop/5.2.0/src/kdevelop-5.2.0.tar.xz"
  sha256 "88e7a8f2f57a4c688da7a6d522b06e2e70ebddf2f9129b8f93e4c74df029e900"

  head "git://anongit.kde.org/kdevelop.git"

  depends_on "boost" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build
  depends_on "KDE-mac/kde/kdevelop-pg-qt" => :build

  depends_on "gdb" => :optional
  depends_on "cppcheck" => :optional
  depends_on "subversion" => :optional
  depends_on "cvs" => :build
  depends_on "gdb" => :build
  depends_on "KDE-mac/kde/konsole" => :optional
  depends_on "KDE-mac/kde/plasma-framework" => :optional
  # depends_on "KDE-mac/kde/okteta" => :optional

  depends_on "KDE-mac/kde/konsole" => [:run, :optional]

  depends_on "cmake" # For cmake integration need set as depends instead of :build ([:build, :optional] fails)
  depends_on "llvm"
  depends_on "KDE-mac/kde/kf5-breeze-icons"
  depends_on "KDE-mac/kde/kf5-kcmutils"
  depends_on "KDE-mac/kde/kf5-kitemmodels"
  depends_on "KDE-mac/kde/kf5-knewstuff"
  depends_on "KDE-mac/kde/kf5-knotifyconfig"
  depends_on "KDE-mac/kde/kf5-ktexteditor"
  depends_on "KDE-mac/kde/kf5-threadweaver"
  depends_on "KDE-mac/kde/grantlee5"
  depends_on "KDE-mac/kde/libkomparediff2"

  conflicts_with "KDE-mac/kde/kdevplatform", :because => "Now included in Kdevelop"

  patch :DATA

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"
    args << "-DCMAKE_INSTALL_BUNDLEDIR=#{bin}"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
    qtpp = `#{Formula["qt"].bin}/qtpaths --plugin-dir`.chomp
    system "/usr/libexec/PlistBuddy",
      "-c", "Add :LSEnvironment:QT_PLUGIN_PATH string \"#{qtpp}\:#{HOMEBREW_PREFIX}/lib/qt5/plugins\"",
      "#{bin}/kdevelop.app/Contents/Info.plist"
  end

  def post_install
    system HOMEBREW_PREFIX/"bin/update-mime-database", HOMEBREW_PREFIX/"share/mime"
    ln_sf HOMEBREW_PREFIX/"share/icons/breeze/breeze-icons.rcc", HOMEBREW_PREFIX/"share/kdevelop/icontheme.rcc"
  end

  def caveats; <<-EOS.undent
      You need to make sime manual steps in order to make this formula work:
        ln -sf "$(brew --prefix)/share/kdevappwizard" "$HOME/Library/Application Support"
        ln -sf "$(brew --prefix)/share/kdevclangsupport" "$HOME/Library/Application Support"
        ln -sf "$(brew --prefix)/share/kdevcodeutils" "$HOME/Library/Application Support"
        ln -sf "$(brew --prefix)/share/kdevelop" "$HOME/Library/Application Support"
        ln -sf "$(brew --prefix)/share/kdevfiletemplates" "$HOME/Library/Application Support"
        ln -sf "$(brew --prefix)/share/kdevgdb" "$HOME/Library/Application Support"
        ln -sf "$(brew --prefix)/share/kdevmanpage" "$HOME/Library/Application Support"
        ln -sf "$(brew --prefix)/share/kdevqmakebuilder" "$HOME/Library/Application Support"
        ln -sf "$(brew --prefix)/share/kdevqmljssupport" "$HOME/Library/Application Support"
        mkdir -p $HOME/Applications/KDE
        ln -sf "#{prefix}/bin/kdevelop.app" $HOME/Applications/KDE/
      EOS
  end
end

__END__
diff --git a/app/CMakeLists.txt b/app/CMakeLists.txt
index 43574b58e4..8d9cd8b4ab 100644
--- a/app/CMakeLists.txt
+++ b/app/CMakeLists.txt
@@ -98,4 +98,5 @@ install( PROGRAMS org.kde.kdevelop.desktop  DESTINATION  ${KDE_INSTALL_APPDIR} )
 install( PROGRAMS org.kde.kdevelop_ps.desktop  DESTINATION  ${KDE_INSTALL_APPDIR} )
 install( FILES kdevelop.notifyrc DESTINATION ${KDE_INSTALL_KNOTIFY5RCDIR} )
 install( FILES kdevelop.xml DESTINATION ${KDE_INSTALL_MIMEDIR} )
-update_xdg_mimetypes( ${KDE_INSTALL_MIMEDIR} )
+# Need generate out of brew by update-mime-database
+#update_xdg_mimetypes( ${KDE_INSTALL_MIMEDIR} )
diff --git a/plugins/clang/CMakeLists.txt b/plugins/clang/CMakeLists.txt
index cbf6b2c9ce..aaea30c9a5 100644
--- a/plugins/clang/CMakeLists.txt
+++ b/plugins/clang/CMakeLists.txt
@@ -135,4 +135,5 @@ target_link_libraries(kdevclangsupport
 )
 
 install(FILES kdevclang.xml DESTINATION ${KDE_INSTALL_MIMEDIR})
-update_xdg_mimetypes(${KDE_INSTALL_MIMEDIR})
+# Need generate out of brew by update-mime-database
+#update_xdg_mimetypes(${KDE_INSTALL_MIMEDIR})
