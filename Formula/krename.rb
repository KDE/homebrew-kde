class Krename < Formula
  desc "Very powerful batch file renamer"
  homepage "http://www.krename.net/"
  version "5.0.1"
  url "git://anongit.kde.org/krename.git", :commit => "db407cbfa2d3528dcf4b5b59ae9c5f9edbf13b7c"

  head "git://anongit.kde.org/krename.git"
  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "ninja" => :build

  depends_on "exiv2"
  depends_on "hicolor-icon-theme"
  depends_on "KDE-mac/kde/kf5-breeze-icons"
  depends_on "KDE-mac/kde/kf5-kio"
  depends_on "KDE-mac/kde/kf5-kjs"
  depends_on "podofo"
  depends_on "taglib"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
    # Extract Qt plugin path
    qtpp = `#{Formula["qt"].bin}/qtpaths --plugin-dir`.chomp
    system "/usr/libexec/PlistBuddy",
    "-c", "Add :LSEnvironment:QT_PLUGIN_PATH string \"#{qtpp}\:#{HOMEBREW_PREFIX}/lib/qt5/plugins\"",
    "#{bin}/krename.app/Contents/Info.plist"
  end

  def post_install
    mkdir_p HOMEBREW_PREFIX/"share/krename"
    ln_sf HOMEBREW_PREFIX/"share/icons/breeze/breeze-icons.rcc", HOMEBREW_PREFIX/"share/krename/icontheme.rcc"
  end

  def caveats; <<~EOS
    You need to take some manual steps in order to make this formula work:
       ln -sfv "$(brew --prefix)/share/krename" "$HOME/Library/Application Support"
       ln -sfv "$(brew --prefix)/share/kservices5" "$HOME/Library/Application Support"
       mkdir -pv "$HOME/Applications/KDE"
       ln -sfv "$(brew --prefix)/opt/krename/bin/krename.app" "$HOME/Applications/KDE"
  EOS
  end

  test do
    assert `"#{bin}/krename.app/Contents/MacOS/krename" --help | grep -- --help` =~ /--help/
  end
end
