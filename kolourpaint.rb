class Kolourpaint < Formula
  desc "Paint Program"
  homepage "https://kde.org/applications/graphics/kolourpaint/"
  url "https://download.kde.org/stable/applications/17.08.3/src/kolourpaint-17.08.3.tar.xz"
  sha256 "4c23dee5c76524d16f0be397a02fd2516129e72001b96a19ab2d2fe348c084f8"
  revision 1

  head "git://anongit.kde.org/kolourpaint.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build
  depends_on "KDE-mac/kde/kf5-kdesignerplugin" => :build

  depends_on "KDE-mac/kde/kf5-breeze-icons"
  depends_on "KDE-mac/kde/kf5-kdelibs4support"

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
    # Extract Qt plugin path
    qtpp = `#{Formula["qt"].bin}/qtpaths --plugin-dir`.chomp
    system "/usr/libexec/PlistBuddy",
      "-c", "Add :LSEnvironment:QT_PLUGIN_PATH string \"#{qtpp}\:#{HOMEBREW_PREFIX}/lib/qt5/plugins\"",
      "#{bin}/kolourpaint.app/Contents/Info.plist"
  end

  def post_install
    ln_sf HOMEBREW_PREFIX/"share/icons/breeze/breeze-icons.rcc", HOMEBREW_PREFIX/"share/kolourpaint/icontheme.rcc"
  end

  def caveats; <<-EOS.undent
    You need to take some manual steps in order to make this formula work:
      ln -sf "$(brew --prefix)/share/kolourpaint" "$HOME/Library/Application Support"
      ln -sf "$(brew --prefix)/share/kxmlgui5" "$HOME/Library/Application Support"
      ln -sf "$(brew --prefix)/share/metainfo" "$HOME/Library/Application Support"
      mkdir -p $HOME/Applications/KDE
      ln -sf "#{prefix}/bin/kolourpaint.app" $HOME/Applications/KDE/
    EOS
  end
end
