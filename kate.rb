class Kate < Formula
  desc "Advanced KDE Text Editor"
  homepage "https://kate-editor.org"
  url "https://download.kde.org/stable/applications/17.08.3/src/kate-17.08.3.tar.xz"
  sha256 "7d0c76d58294436a1646736427dd42966b2e6ef883a91ba3f97deaa080835ffa"
  revision 1

  head "git://anongit.kde.org/kate.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build
  depends_on "KDE-mac/kde/kf5-plasma-framework" => :build

  depends_on "KDE-mac/kde/konsole" => [:run, :optional]

  depends_on "KDE-mac/kde/kf5-kactivities"
  depends_on "KDE-mac/kde/kf5-kitemmodels"
  depends_on "KDE-mac/kde/kf5-knewstuff"
  depends_on "KDE-mac/kde/kf5-ktexteditor"
  depends_on "KDE-mac/kde/kf5-threadweaver"

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
      "#{bin}/kate.app/Contents/Info.plist"
    system "/usr/libexec/PlistBuddy",
      "-c", "Add :LSEnvironment:QT_PLUGIN_PATH string \"#{qtpp}\:#{HOMEBREW_PREFIX}/lib/qt5/plugins\"",
      "#{bin}/kwrite.app/Contents/Info.plist"
  end

  def post_install
    mkdir_p HOMEBREW_PREFIX/"share/kate"
    ln_sf HOMEBREW_PREFIX/"share/icons/breeze/breeze-icons.rcc", HOMEBREW_PREFIX/"share/kate/icontheme.rcc"
    mkdir_p HOMEBREW_PREFIX/"share/kwrite"
    ln_sf HOMEBREW_PREFIX/"share/icons/breeze/breeze-icons.rcc", HOMEBREW_PREFIX/"share/kwrite/icontheme.rcc"
  end

  def caveats; <<-EOS.undent
    You need to take some manual steps in order to make this formula work:
      ln -sf "$(brew --prefix)/share/kate" "$HOME/Library/Application Support"
      ln -sf "$(brew --prefix)/share/kwrite" "$HOME/Library/Application Support"
      ln -sf "$(brew --prefix)/share/kateproject" "$HOME/Library/Application Support"
      ln -sf "$(brew --prefix)/share/katexmltools" "$HOME/Library/Application Support"
      ln -sf "$(brew --prefix)/share/kservices5" "$HOME/Library/Application Support"
      ln -sf "$(brew --prefix)/share/metainfo" "$HOME/Library/Application Support"
      ln -sf "$(brew --prefix)/share/plasma" "$HOME/Library/Application Support"
      mkdir -p $HOME/Applications/KDE
      ln -sf "#{prefix}/bin/kate.app" $HOME/Applications/KDE/
      ln -sf "#{prefix}/bin/kwrite.app" $HOME/Applications/KDE/
    EOS
  end

  test do
    assert `/Applications/KDE/kate.app/Contents/MacOS/kate --help | grep -- --help` =~ /--help/
  end
end
