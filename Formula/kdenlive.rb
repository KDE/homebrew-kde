class Kdenlive < Formula
  desc "Video editor"
  homepage "https://www.kdenlive.org/"
  url "https://download.kde.org/stable/applications/18.12.2/src/kdenlive-18.12.2.tar.xz"
  sha256 "47675eca0af26b4716aa587612f05364b6e49da47eb42e9f19d2fbd8aa236d16"

  head "git://anongit.kde.org/kdenlive.git"

  depends_on "cmake" => :build
  depends_on "kf5-extra-cmake-modules" => :build
  depends_on "kf5-kdoctools" => :build
  depends_on "kf5-kfilemetadata"
  depends_on "kf5-knewstuff"
  depends_on "kf5-knotifyconfig"
  depends_on "mlt"
  depends_on "qt-webkit"
  depends_on "cdrtools" => :optional
  depends_on "dvdauthor" => :optional
  depends_on "ffmpeg" => :optional
  depends_on "libdv" => :optional

  def install
    args = std_cmake_args
    args << "-DKDE_INSTALL_BUNDLEDIR=#{bin}"
    args << "-DKDE_INSTALL_LIBDIR=lib"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DBUILD_TESTING=OFF"
    args << "-DCMAKE_PREFIX_PATH=" + Formula["qt"].opt_prefix + "/lib/cmake"
    args << "-DQt5WebKitWidgets_DIR=" + Formula["qt-webkit"].opt_prefix + "/lib/cmake/Qt5WebKitWidgets"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
    # Extract Qt plugin path
    qtpp = `#{Formula["qt"].bin}/qtpaths --plugin-dir`.chomp
    system "/usr/libexec/PlistBuddy", "-c",
           "Add :LSEnvironment:QT_PLUGIN_PATH string \"#{qtpp}\:#{HOMEBREW_PREFIX}/lib/qt5/plugins\"",
           "#{bin}/kdenlive.app/Contents/Info.plist"

    # Rename the .so files
    mv "#{lib}/qt5/plugins/mltpreview.so", "#{lib}/qt5/plugins/mltpreview.dylib"
  end

  def post_install
    mkdir_p "#{HOMEBREW_PREFIX}/share/kdenlive"
    ln_sf "#{HOMEBREW_PREFIX}/share/icons/breeze/breeze-icons.rcc", "#{HOMEBREW_PREFIX}/share/kdenlive/icontheme.rcc"
  end

  def caveats; <<~EOS
    You need to take some manual steps in order to make this formula work:
      ln -sfv "$(brew --prefix)/share/kdenlive" "$HOME/Library/Application Support"
      mkdir -pv "$HOME/Applications/KDE"
      ln -sfv "$(brew --prefix)/opt/kdenlive/bin/kdenlive.app" "$HOME/Applications/KDE"

    OTHER NOTES
    -----------
    When starting the program it may be crash, solved it changing in ~/Library/Preferences/kdenliverc
    from true to false: Window-Maximized = false
    For ffmpeg, you could install --with-: chromaprint fdk-aac fontconfig freetype frei0r game-music-emu libass libbluray libbs2b libcaca libgsm libmodplug libsoxr libssh libvidstab libvorbis libvpx opencore-amr openh264 openjpeg openssl opus rtmpdump rubberband sdl2 snappy speex srt tesseract theora tools two-lame wavpack webp x265 xz zeromq zimg

    There seems to be a problem with librsvg
  EOS
  end

  test do
    assert `"#{bin}"/kdenlive.app/Contents/MacOS/kdenlive --help | grep -- --help` =~ /--help/
  end
end
