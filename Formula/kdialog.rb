class Kdialog < Formula
  desc "Utility for displaying dialog boxes from shell scripts"
  homepage "https://kde.org/applications/utilities/org.kde.kdialog"
  url "https://download.kde.org/stable/release-service/19.12.2/src/kdialog-19.12.2.tar.xz"
  sha256 "974bd61018ce5883a2c4e3cdc0dba891f2018dc2bf6e668b02afc2560b69b5ff"
  head "git://anongit.kde.org/dolphin.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "ninja" => :build
  depends_on "KDE-mac/kde/kf5-kdbusaddons"
  depends_on "KDE-mac/kde/kf5-kguiaddons"
  depends_on "KDE-mac/kde/kf5-kiconthemes"
  depends_on "KDE-mac/kde/kf5-kio"
  depends_on "KDE-mac/kde/kf5-knotifications"
  depends_on "KDE-mac/kde/kf5-ktextwidgets"
  depends_on "KDE-mac/kde/kf5-kwindowsystem"
  depends_on "KDE-mac/kde/kf5-kcoreaddons" => :optional

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"
    args << "-DCMAKE_INSTALL_BUNDLEDIR=#{bin}"

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
    # # Extract Qt plugin path
    # qtpp = `#{Formula["qt"].bin}/qtpaths --plugin-dir`.chomp
    # system "/usr/libexec/PlistBuddy",
    #   "-c", "Add :LSEnvironment:QT_PLUGIN_PATH string \"#{qtpp}\:#{HOMEBREW_PREFIX}/lib/qt5/plugins\"",
    #   "#{bin}/dolphin.app/Contents/Info.plist"
  end

  # def post_install
  #   mkdir_p HOMEBREW_PREFIX/"share/dolphin"
  #   ln_sf HOMEBREW_PREFIX/"share/icons/breeze/breeze-icons.rcc", HOMEBREW_PREFIX/"share/dolphin/icontheme.rcc"
  # end

  def caveats; <<~EOS
    You need to take some manual steps in order to make this formula work:
      "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
  EOS
  end

  test do
    assert `"#{bin}/kdialog.app/Contents/MacOS/kdialog" --help | grep -- --help` =~ /--help/
  end
end
